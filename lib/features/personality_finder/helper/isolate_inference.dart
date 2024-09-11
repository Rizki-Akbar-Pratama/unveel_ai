/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;
import '../../../core/utils/image_utils.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort,
        debugName: _debugName);
    _sendPort = await _receivePort.first;
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    var output;
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      image_lib.Image? img;
      if (isolateModel.isCameraFrame()) {
        img = ImageUtils.convertCameraImage(isolateModel.cameraImage!);
      } else {
        img = isolateModel.image;
      }

      // resize original image to match model shape.
      image_lib.Image imageInput = image_lib.copyResize(
        img!,
        width: isolateModel.inputShape[1],
        height: isolateModel.inputShape[2],
      );

      if (Platform.isAndroid && isolateModel.isCameraFrame()) {
        imageInput = image_lib.copyRotate(imageInput, angle: 0);
      }

      final imageMatrix = List.generate(
        imageInput.height,
            (y) => List.generate(
          imageInput.width,
              (x) {
            final pixel = imageInput.getPixel(x, y);
            return [
              (pixel.r - 127.5) / 127.5,
              (pixel.g - 127.5) / 127.5,
              (pixel.b - 127.5) / 127.5
            ];
          },
        ),
      );

      // Set tensor input
      final input = [imageMatrix];

      // // Run inference
      Interpreter interpreter = Interpreter.fromAddress(isolateModel.interpreterAddress);

      if(isolateModel.detectionType == 0 ) {
        // Set tensor output
        output = _prepareOutput(isolateModel.outputShape[1]);

        interpreter.runForMultipleInputs([input], output);
      }

      if(isolateModel.detectionType == 1) {
        Uint8List byte8 = imageToByteListFloat32(imageInput, 200, 127.5, 127.5);

        final outputAge = [[0.0]];
        interpreter.run(byte8, outputAge);

        output = {0: outputAge};
      }

      if(isolateModel.detectionType == 2) {
        output = _prepareOutputFaceMesh();

        interpreter.runForMultipleInputs([input], output);
      }

      isolateModel.responsePort.send(output);
    }
  }

  static Map<int, Object> _prepareOutput(int output) {
    // outputmap
    final outputMap = <int, Object>{};

    // 1 * 1 * 1 contains heatmaps
    outputMap[0] = [List.filled(output, 0.0)];

    return outputMap;
  }

  static Map<int, Object> _prepareOutputFaceMesh() {
    // outputmap
    final outputMap = <int, Object>{};

    // 1 * 1 * 1 contains heatmaps
    outputMap[0] = [[[List.filled(1404, 0.0)]]];
    outputMap[1] = [List.filled(1, List.filled(1, List.filled(1, 0.0)))];

    return outputMap;
  }

  static Uint8List imageToByteListFloat32(image_lib.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (pixel.r - mean) / std;
        buffer[pixelIndex++] = (pixel.g - mean) / std;
        buffer[pixelIndex++] = (pixel.b - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

}

class InferenceModel {
  CameraImage? cameraImage;
  image_lib.Image? image;
  int interpreterAddress;
  List<int> inputShape;
  List<int> outputShape;
  late SendPort responsePort;
  late int detectionType = 0;

  InferenceModel(this.cameraImage, this.image, this.interpreterAddress,
       this.inputShape, this.outputShape, this.detectionType);

  // check if it is camera frame or still image
  bool isCameraFrame() {
    return cameraImage != null;
  }
}
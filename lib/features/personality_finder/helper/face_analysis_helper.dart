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

import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:unveels/features/personality_finder/data/models/labels.dart';
import 'package:unveels/features/personality_finder/data/models/recognition.dart';


import 'isolate_inference.dart';
import '../data/models/model.dart';
import '../data/models/labels.dart';
import '../data/models/recognition.dart';

class FaceAnalysisHelper {
  static const modelPathCheeksBone = Cheek_Bones;
  static const modelPathEyeAngle = Eye_Angle;
  static const modelEyeDistance = Eye_Distance;
  static const modelEyeShape = Eye_Shape;
  static const modelAge = Age;
  static const modelFaceMesh = Face_Mesh;

  late final Interpreter interpreter;
  late final Interpreter interpreterEyeAngle;
  late final Interpreter interpreterEyeDistance;
  late final Interpreter interpreterEyeShape;
  late final Interpreter interpreterAge;
  late final Interpreter interpreterFaceMesh;

  late final IsolateInference isolateInference;

  late Tensor inputTensor;
  late Tensor inputTensorAge;
  late Tensor inputFaceMesh;
  late Tensor outputTensor;
  late Tensor outputTensorEyeShape;
  late Tensor outputTensorAge;

  // Load model
  Future<void> _loadModel() async {
    final options = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      options.addDelegate(XNNPackDelegate());
    }

    // Use Metal Delegate
    if (Platform.isIOS) {
      options.addDelegate(GpuDelegate());
    }

    // Load model from assets
    interpreter = await Interpreter.fromAsset(modelPathCheeksBone, options: options);
    interpreterEyeAngle = await Interpreter.fromAsset(modelPathEyeAngle, options: options);
    interpreterEyeDistance = await Interpreter.fromAsset(modelEyeDistance, options: options);
    interpreterEyeShape = await Interpreter.fromAsset(modelEyeShape, options: options);
    interpreterAge = await Interpreter.fromAsset(modelAge, options: options);
    interpreterFaceMesh = await Interpreter.fromAsset(modelFaceMesh, options: options);

    // Get tensor input shape
    inputTensor = interpreter.getInputTensors().first;
    inputTensorAge = interpreterAge.getInputTensors().first;
    inputFaceMesh = interpreterFaceMesh.getInputTensors().first;

    // Get tensor output shape
    outputTensor = interpreter.getOutputTensors().first;
    outputTensorEyeShape = interpreterEyeShape.getOutputTensors().first;
    outputTensorAge = interpreterAge.getOutputTensors().first;


    log('Interpreter loaded successfully');
  }

  Future<void> initHelper() async {
    _loadModel();
    isolateInference = IsolateInference();
    await isolateInference.start();
  }

  Future<List<double>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;

    return results[0][0];
  }

  Future<Map<int, Object>> _inferenceFaceMesh(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;

    return results;
  }

  // inference camera frame
  Future<void> inferenceCameraFrame(
      CameraImage cameraImage) async {
    var isolateModel = InferenceModel(cameraImage, null, interpreter.address,
         inputTensor.shape, outputTensor.shape, 0);
  }

  // inference still image
  Future<Map<String, dynamic>> inferenceImage(img.Image image) async {
    // face analysis
    var isolateModel = InferenceModel(null, image, interpreter.address,
        inputTensor.shape, outputTensor.shape, 0);
    var isolateModelEyeAngle = InferenceModel(null, image, interpreterEyeAngle.address, inputTensor.shape, outputTensor.shape,0);
    var isolateModelEyeDistance = InferenceModel(null, image, interpreterEyeDistance.address, inputTensor.shape, outputTensor.shape,0);
    var isolateModelEyeShape = InferenceModel(null, image, interpreterEyeShape.address, inputTensor.shape, outputTensorEyeShape.shape,0);
    var isolateModelAge = InferenceModel(null, image, interpreterAge.address, inputTensorAge.shape, outputTensorAge.shape,1);
    // custom facemesh
    var isolateModelFaceMesh = InferenceModel(null, image, interpreterFaceMesh.address, inputFaceMesh.shape, [0], 2);

    //  image inference time
    var inferenceTimeStart = DateTime.now().millisecondsSinceEpoch;

    final String outputCheeksbone = Cheeksbones[Recognition.findMaxIndex(await _inference(isolateModel))];
    final String outputEyeAngle = Eyeangle[Recognition.findMaxIndex(await _inference(isolateModelEyeAngle))];
    final String outputEyeDistance = Eyedistance[Recognition.findMaxIndex(await _inference(isolateModelEyeDistance))];
    final String outputEyeShape = Eyeshape[Recognition.findMaxIndex(await _inference(isolateModelEyeShape))];
    final List<double> outputAge = await _inference(isolateModelAge);
    final Map<int, Object> outputFaceMesh = await _inferenceFaceMesh(isolateModelFaceMesh);

    // Prepocess landmark
    final List<List<List<List<double>>>> outputLandmarks  = outputFaceMesh[0] as List<List<List<List<double>>>>;

    // faltten landmark
    final List<double> landmarksFlatten = outputLandmarks
        .expand((i) => i)
        .expand((i) => i)
        .expand((i) => i)
        .toList();

    final List<List<double>> reshapeLandmarks = Recognition.reshape(landmarksFlatten);

    final List<Map<String, double>> landmarks = Recognition.calculateLandmarks(reshapeLandmarks);


    // resize original image to match model shape.
    img.Image imageInput = img.copyResize(
      image!,
      width: 192,
      height: 192,
    );

    /*if (Platform.isAndroid && isolateModel.isCameraFrame()) {
      imageInput = img.copyRotate(imageInput, angle: 0);
    }*/

    final List<int> lips = [178, 179, 180, 87, 86, 85, 14, 15, 16, 317, 316, 315];
    Map<String, int> lipColor = Recognition.getAverageColorFromLips(imageInput, landmarks, lips);

    final List<int> eyebrows = [107, 66, 105, 63, 70, 336, 296, 334, 293];
    Map<String, int> eyebrowColor = Recognition.getAverageColorFromEyeBrow(imageInput, landmarks, eyebrows);

    List<Recognition> recognitions = [];
    recognitions.add(Recognition(outputCheeksbone, outputEyeAngle, outputEyeDistance, outputEyeShape, outputAge[0], landmarks, lipColor, eyebrowColor));

    var inferenceElapsedTime =
        DateTime.now().millisecondsSinceEpoch - inferenceTimeStart;

    print("Inference Time : $inferenceElapsedTime");
    
    return {
      'Recognition': recognitions
    };
  }

  Future<void> close() async {
    isolateInference.close();
    print("Close isolate inference");
  }
}
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unveels/features/personality_finder/helper/face_analysis_helper.dart';
import 'package:unveels/shared/configs/route_config.dart';
import 'package:image/image.dart' as img;


import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../../data/models/recognition.dart';
import '../widgets/pf_analysis_results_widget.dart';

class PFLivePage extends StatefulWidget {
  const PFLivePage({
    super.key,
  });

  @override
  State<PFLivePage> createState() => _PFLivePageState();
}

class _PFLivePageState extends State<PFLivePage> {
  FaceAnalysisHelper? _faceAnalysisHelper;

  late LiveStep step;
  /// Realtime stats
  Map<String, String>? stats;

  StreamSubscription? _subscription;
  XFile? _imageFile;
  bool _isShowAnalysisResults = false;
  bool _isAnalyzing = false;
  List<Recognition>? _recognition;

  @override
  void initState() {
    super.initState();
    _faceAnalysisHelper = FaceAnalysisHelper();
    _faceAnalysisHelper!.initHelper();
    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
  }

  Future<void> scanning(XFile xfileImage) async {
    print("Do Scanning  $xfileImage");
    final path = xfileImage.path;
    final bytes = await File(path).readAsBytes();
    final img.Image? image = img.decodeImage(bytes);
    final results =  await _faceAnalysisHelper!.inferenceImage(image!);
    setState(() {
      _recognition = results['Recognition'];
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? screenRecordBackrgoundColor;
    if (_isShowAnalysisResults) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body:
          //debug landmark position
      /*(_recognition?[0].landmarks != null ) ? Stack(
        children: [
          Image.file(fit: BoxFit.fill,
            File(_imageFile!.path),
            width: 192,
            height: 192,
          ),
          CustomPaint(
            painter: DrawLandmarks()..updateLandmark(_recognition?[0].landmarks),
          )
        ],
      ): */
      LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        body: _buildBody,
        screenRecordBackrgoundColor: screenRecordBackrgoundColor,
        onLiveStepChanged: (value) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
          }
        },
        onImageTaken: (XFile imageFile) {
          if(imageFile != null) {
            setState(() {
              _isAnalyzing = true;
              _imageFile = imageFile;
            });
          }
        },
      ),
    );
  }

  Widget get _buildBody{
    switch (step) {
      case LiveStep.photoSettings:
        return const SizedBox.shrink();
      case LiveStep.scanningFace:
        // do scanning
        if (_imageFile != null) {
          scanning(_imageFile!);
        }
        // show oval face container
        return Center(
          child: ClipOval(
            clipper: FaceClipper(),
            child: Container(
              width: 330,
              height: 330,
              color: const Color(0xFF289900).withOpacity(0.5),
            ),
          ),
        );

      case LiveStep.scannedFace:
        if (_isAnalyzing == false) {
         if (_isShowAnalysisResults) {
            return PFAnalysisResultsWidget(recognition: _recognition, profile: _imageFile,);
          }
          return BottomCopyrightWidget(
            child: Column(
              children: [
                ButtonWidget(
                  text: 'PERSONALITY FINDER',
                  width: context.width / 2,
                  backgroundColor: Colors.black,
                  onTap: _onPersonalityFinder,
                ),
              ],
            ),
          );
        }

        // show oval face container
        return Center(
          child: ClipOval(
            clipper: FaceClipper(),
            child: Container(
              width: 330,
              height: 330,
              color: const Color(0xFF289900).withOpacity(0.5),
            ),
          ),
        );

      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onPersonalityFinder() async {
    // show analysis results
    setState(() {
      _isShowAnalysisResults = true;
    });
  }
}

class DrawLandmarks extends CustomPainter {
  DrawLandmarks() ;
  late final List<Map<String, double>> _landmarks;

  updateLandmark(List<Map<String, double>> landmarks) {
    _landmarks = landmarks;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    for (var landmark in _landmarks) {
      final dx = landmark['x']!;
      final dy = landmark['y']!;
      canvas.drawCircle(Offset(dx, dy), 3, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawLandmarks oldDelegate) {
    return oldDelegate._landmarks != _landmarks;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/widgets/cameras/camera_widget.dart';
import '../../../../shared/widgets/lives/play_video_widget.dart';
import '../../../features/find_the_look/presentation/pages/ftl_live_page.dart';
import '../../extensions/live_configuration_step_parsing.dart';
import '../../extensions/live_step_parsing.dart';
import 'live_configuration_step_widget.dart';

class LiveWidget extends StatefulWidget {
  final LiveStep liveStep;
  final LiveType liveType;
  final XFile? file;
  final Function(LiveStep value) onLiveStepChanged;
  final Function(XFile file)? onImageTaken;
  final Widget body;
  final Color? screenRecordBackrgoundColor;

  const LiveWidget({
    super.key,
    required this.liveStep,
    required this.liveType,
    this.file,
    required this.onLiveStepChanged,
    this.onImageTaken,
    required this.body,
    this.screenRecordBackrgoundColor,
  });

  @override
  State<LiveWidget> createState() => _LiveWidgetState();
}

class _LiveWidgetState extends State<LiveWidget> {
  LiveConfigurationStep? _liveConfigurationStep;
  int? _countdownFaceScanning;
  int? _prevCountDownFaceScanning;
  XFile? _capturedFile;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    if (widget.liveStep == LiveStep.photoSettings) {
      _startLiveConfiguration();
    }
  }

  Future<void> _startLiveConfiguration() async {
    // for testing, loop auto increment step every 3 seconds
    for (final step in LiveConfigurationStep.values) {
      await Future.delayed(const Duration(seconds: 3));

      if (mounted) {
        setState(() {
          _liveConfigurationStep = step;
        });
      }
    }

    // start scanning countdown
    for (var i = 3; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() {
          _countdownFaceScanning = i;
          _prevCountDownFaceScanning = i;
        });
      }
    }

    // reset countdown
    if (mounted) {
      setState(() {
        _countdownFaceScanning = null;
      });
    }

    // change step to scanning face
    widget.onLiveStepChanged(LiveStep.scanningFace);

    // delayed scanning for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // change step to scanned face
    widget.onLiveStepChanged(LiveStep.scannedFace);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImage,
        // linear gradient
        Container(
          margin: const EdgeInsets.only(
            top: SizeConfig.appBarMargin,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF000000).withOpacity(0.0),
                const Color(0xFF000000).withOpacity(0.9),
              ],
            ),
          ),
        ),
        // body
        Padding(
          padding: const EdgeInsets.only(
            top: SizeConfig.appBarMargin,
          ),
          child: _buildBody,
        ),
      ],
    );
  }

  Widget get _buildImage {
    final fileToShow = _capturedFile ?? widget.file;
    switch (widget.liveType) {
      case LiveType.importPhoto:
        // TODO: Recording screen
        // show image
        return Image.file(
          File(fileToShow!.path),
          fit: BoxFit.cover,
          width: context.width,
          height: context.height,
        );
      case LiveType.importVideo:
        // TODO: Recording screen
        // show video
        return PlayVideoWidget(
          file: File(fileToShow!.path),
          isShowScreenRecording: true,
          screenRecordBackrgoundColor: widget.screenRecordBackrgoundColor,
        );
      case LiveType.liveCamera:
        // show live camera
        return CameraWidget(
          isShowScreenRecording: true,
          backgroundColor: widget.screenRecordBackrgoundColor,
          countdown: _prevCountDownFaceScanning,
          onPictureTaken: (XFile capturedFile) {
            if (_prevCountDownFaceScanning == 0) {
              widget.onImageTaken!(capturedFile);
              // reset prevCountdownFaceScanning
              setState(() {
                _prevCountDownFaceScanning = null;
              });
            }
          },
        );
    }
  }

  Widget get _buildBody {
    if (_countdownFaceScanning != null) {
      // show countdown for prepare start scanning
      return Center(
        child: Text(
          _countdownFaceScanning?.toString() ?? "",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 128,
          ),
        ),
      );
    }

    switch (widget.liveStep) {
      case LiveStep.photoSettings:
        return LiveConfigurationStepWidget(
          liveConfigurationStep: _liveConfigurationStep,
        );
      case LiveStep.scanningFace:
      case LiveStep.scannedFace:
      case LiveStep.makeup:
        return widget.body;
    }
  }
}

import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../core/observers/logger.dart';
import '../../../core/utils/toast_info.dart';
import '../../../service_locator.dart';
import '../../extensions/context_parsing.dart';
import '../../extensions/toast_type_parsing.dart';
import '../app_bars/app_bar_widget.dart';
import '../bottom_sheets/share_video_bottom_sheet.dart';
import '../buttons/recording_controllers_widget.dart';

enum ScreenRecordingStatus {
  none,
  recording,
  paused,
}

const double _kAppBarArea = 90;

class CameraWidget extends StatefulWidget {
  final bool? isShowScreenRecording;
  final Color? backgroundColor;
  final Function(XFile capturedFile) onPictureTaken;
  final int? countdown;

  const CameraWidget({
    super.key,
    this.isShowScreenRecording,
    this.backgroundColor,
    required this.onPictureTaken,
    this.countdown
  });

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget>
    with WidgetsBindingObserver {
  CameraController? controller;
  ScreenRecordingStatus? _screenRecordingStatus;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    WidgetsBinding.instance.addObserver(this);

    // Initialize the camera.
    _initCamera();

    // Initialize the screen recording status.
    _initScreenRecordingStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    controller?.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // take picture
    if(widget.countdown == 0) {
      _takePicture();
    }

    final mediaSize = MediaQuery.of(context).size;
    final scale = 1 / (controller!.value.aspectRatio * mediaSize.aspectRatio);
    return Scaffold(
      appBar: AppBarWidget(
        iconBackgroundColor: const Color(0xFF000000).withOpacity(0.24),
        backgroundColor: widget.backgroundColor ?? Colors.transparent,
        showCloseButton: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          ClipRect(
            clipper: _MediaSizeClipper(mediaSize),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.topCenter,
              child: CameraPreview(
                controller!,
              ),
            ),
          ),
          _buildScreenRecordingButton,
        ],
      ),
    );
  }

  Widget get _buildScreenRecordingButton {
    if (widget.isShowScreenRecording != true) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: _kAppBarArea,
      ),
      child: RecordingControllersWidget(
        screenRecordingStatus: _screenRecordingStatus,
        backgroundColor: widget.backgroundColor,
        onStartRecording: _onRecordVideo,
        onStopRecording: _onStopVideo,
        onPauseRecording: _onPauseVideo,
        onResumeRecording: _onResumeVideo,
      ),
    );
  }

  void _initCamera() {
    final cameras = availableCameras();

    cameras.then((cameras) {
      final camera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _initializeCameraController(camera);
    });
  }

  void _initScreenRecordingStatus() {
    if (widget.isShowScreenRecording == true) {
      _screenRecordingStatus = ScreenRecordingStatus.none;
    }
  }

  void _initializeCameraController(CameraDescription cameraDescription) {
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
    );

    controller!.initialize().then((_) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  Future<void> _takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }
    try {
      final XFile picture = await controller!.takePicture();
      widget.onPictureTaken(picture);
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  // FIXME: If using this throwing error when app is in background
  // The following CameraException was thrown building ValueListenableBuilder<CameraValue>(state: _ValueListenableBuilderState<CameraValue>#58d03):
  // CameraException(Disposed CameraController, buildPreview() was called on a disposed CameraController.)
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final cameraController = controller;

  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }

  //   if (state == AppLifecycleState.inactive) {
  //     // FIXME: Fix camera inactive

  //     // dispose the camera controller.
  //     cameraController.dispose();

  //     if (widget.isShowScreenRecording == true) {
  //       // dispose the timer
  //       _timer?.cancel();

  //       // dispose the screen recording status
  //       setState(() {
  //         _screenRecordingStatus = null;
  //       });
  //     }
  //   } else if (state == AppLifecycleState.resumed) {
  //     // FIXME: Fix camera resumed
  //     // initialize the camera controller.
  //     _initializeCameraController(
  //       cameraController.description,
  //     );

  //     // initialize the screen recording status.
  //     _initScreenRecordingStatus();

  //     // initialize the timer
  //     if (_screenRecordingStatus == ScreenRecordingStatus.recording) {
  //       _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //         setState(() {
  //           _recordingDuration += const Duration(seconds: 1);
  //         });
  //       });
  //     }
  //   }
  // }

  Future<void> _onRecordVideo() async {
    try {
      Logger.info('_onRecordVideo');

      if (!controller!.value.isInitialized) {
        return;
      }

      // show full screen loading
      context.showFullScreenLoading();

      if (controller!.value.isRecordingVideo) {
        return;
      }

      // prepare for recording video
      await controller!.prepareForVideoRecording();

      // start recording video
      await controller!.startVideoRecording();

      // // Start the timer
      // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //   setState(() {
      //     _recordingDuration += const Duration(seconds: 1);
      //   });
      // });

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.recording;
      });

      Logger.success('_onRecordVideo');
    } catch (error) {
      // show error message
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: 'Failed to record video',
      );

      Logger.error('_onRecordVideo error: $error');
    } finally {
      // hide full screen loading
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onPauseVideo() async {
    try {
      Logger.info('_onPauseVideo');

      if (!controller!.value.isInitialized) {
        return;
      }

      if (!controller!.value.isRecordingVideo) {
        return;
      }

      // show full screen loading
      context.showFullScreenLoading();

      // pause video recording
      await controller!.pauseVideoRecording();

      // // pause the timer
      // _timer?.cancel();

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.paused;
      });

      Logger.success('_onPauseVideo');
    } catch (error) {
      // show error message
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: 'Failed to pause video recording',
      );

      Logger.error('_onPauseVideo error: $error');
    } finally {
      // hide full screen loading
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onResumeVideo() async {
    try {
      Logger.info('_onResumeVideo');

      if (!controller!.value.isInitialized) {
        return;
      }

      if (!controller!.value.isRecordingVideo) {
        return;
      }

      // show full screen loading
      context.showFullScreenLoading();

      // resume video recording
      await controller!.resumeVideoRecording();

      // // resume the timer
      // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      //   setState(() {
      //     _recordingDuration += const Duration(seconds: 1);
      //   });
      // });

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.recording;
      });

      Logger.success('_onResumeVideo');
    } catch (error) {
      // show error message
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: 'Failed to resume video recording',
      );

      Logger.error('_onResumeVideo error: $error');
    } finally {
      // hide full screen loading
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onStopVideo() async {
    try {
      Logger.info('_onStopVideo');

      if (!controller!.value.isInitialized) {
        return;
      }

      if (!controller!.value.isRecordingVideo) {
        return;
      }

      // show full screen loading
      context.showFullScreenLoading();

      final recordedVideo = await controller!.stopVideoRecording();
      Logger.success('_onStopVideo recordedVideo: $recordedVideo');

      // // Stop the timer
      // _timer?.cancel();
      // _timer = null;

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.none;
        // _recordingDuration = Duration.zero;
      });

      // share the recorded video
      _onShareVideo(
        recordedVideo: recordedVideo,
      );
    } catch (error) {
      // show error message
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: 'Failed to stop video recording',
      );

      Logger.error('_onStopVideo error: $error');
    } finally {
      // hide full screen loading
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onShareVideo({
    required XFile recordedVideo,
  }) async {
    // show share confirmation dialog
    await ShareVideoBottomSheet.show(
      context: context,
      video: recordedVideo,
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

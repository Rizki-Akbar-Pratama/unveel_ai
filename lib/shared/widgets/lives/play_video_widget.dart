import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import '../../../core/observers/logger.dart';
import '../../../core/utils/permission_info.dart';
import '../../../core/utils/toast_info.dart';
import '../../../service_locator.dart';
import '../../extensions/context_parsing.dart';
import '../../extensions/object_parsing.dart';
import '../../extensions/toast_type_parsing.dart';
import '../app_bars/app_bar_widget.dart';
import '../bottom_sheets/share_video_bottom_sheet.dart';
import '../buttons/recording_controllers_widget.dart';
import '../cameras/camera_widget.dart';

const double _kAppBarArea = 90;

class PlayVideoWidget extends StatefulWidget {
  final File file;
  final bool? isShowScreenRecording;
  final Color? screenRecordBackrgoundColor;

  const PlayVideoWidget({
    super.key,
    required this.file,
    required this.isShowScreenRecording,
    this.screenRecordBackrgoundColor,
  });

  @override
  State<PlayVideoWidget> createState() => _PlayVideoWidgetState();
}

class _PlayVideoWidgetState extends State<PlayVideoWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  ScreenRecordingStatus? _screenRecordingStatus;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // init play video
    _initPlayVideo();

    if (widget.isShowScreenRecording == true) {
      _screenRecordingStatus = ScreenRecordingStatus.none;
    }
  }

  @override
  void dispose() {
    super.dispose();

    _videoController?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(
        iconBackgroundColor: const Color(0xFF000000).withOpacity(0.24),
        backgroundColor: Colors.transparent,
        showCloseButton: true,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Chewie(
            controller: _chewieController!,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: _kAppBarArea,
            ),
            child: RecordingControllersWidget(
              screenRecordingStatus: _screenRecordingStatus,
              backgroundColor: widget.screenRecordBackrgoundColor,
              onStartRecording: _onStartRecording,
              onPauseRecording: _onPause,
              onResumeRecording: _onResume,
              onStopRecording: _onStop,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initPlayVideo() async {
    try {
      // dispose video controller
      if (_videoController != null) {
        _videoController!.dispose();
      }

      // init video controller
      _videoController = VideoPlayerController.file(widget.file);

      // init video player
      await _videoController!.initialize();

      // dispose chewie controller
      if (_chewieController != null) {
        _chewieController!.dispose();
      }

      // init chewie controller
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: true,
        showControls: false,
      );

      // reload state
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
    }
  }

  Future<void> _onStartRecording() async {
    try {
      // _screenRecorderController!.start();

      // request permission
      final recordPermissions = [
        Permission.phone,
        Permission.storage,
      ];
      await Future.wait(
        recordPermissions.map(
          (permission) => sl<PermissionInfo>().requestPermission(
            permission: permission,
          ),
        ),
      );

      // show full screen loading
      context.showFullScreenLoading();

      // TODO: start screen recording

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.recording;
      });
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
    } finally {
      // hide full screen loading
      context.hideFullScreenLoading;
    }
  }

  Future<void> _onPause() async {
    try {
      // _screenRecorderController!.

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.paused;
      });
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
    }
  }

  Future<void> _onResume() async {
    try {
      // TODO: resume screen recording

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.recording;
      });
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
    }
  }

  Future<void> _onStop() async {
    try {
      Logger.info('_onStop');

      // update screen recording status
      setState(() {
        _screenRecordingStatus = ScreenRecordingStatus.none;
      });

      // show full screen loading
      context.showFullScreenLoading();

      // TODO: stop screen recording

      // share the recorded video
      // _onShareVideo(
      //   recordedVideo: XFile(filePath),
      // );
    } catch (error) {
      sl<ToastInfo>().showToast(
        type: ToastType.error,
        message: error.message,
      );
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

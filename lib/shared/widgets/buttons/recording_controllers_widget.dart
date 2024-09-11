import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/asset_path.dart';
import '../cameras/camera_widget.dart';

class RecordingControllersWidget extends StatefulWidget {
  final ScreenRecordingStatus? screenRecordingStatus;
  final Color? backgroundColor;
  final Function() onStartRecording;
  final Function() onStopRecording;
  final Function() onPauseRecording;
  final Function() onResumeRecording;

  const RecordingControllersWidget({
    super.key,
    required this.screenRecordingStatus,
    this.backgroundColor,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
  });

  @override
  State<RecordingControllersWidget> createState() =>
      _RecordingControllersWidgetState();
}

class _RecordingControllersWidgetState
    extends State<RecordingControllersWidget> {
  Timer? _timer;
  Duration _recordingDuration = Duration.zero;

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.screenRecordingStatus ==
              ScreenRecordingStatus.recording) ...[
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  IconPath.pauseCircle,
                  fit: BoxFit.cover,
                ),
                onPressed: _onPauseRecording,
              ),
            ),
            const SizedBox(
              width: 21,
            ),
          ] else if (widget.screenRecordingStatus ==
              ScreenRecordingStatus.paused) ...[
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  IconPath.playCircle,
                  fit: BoxFit.cover,
                ),
                onPressed: _onResumeRecording,
              ),
            ),
            const SizedBox(
              width: 21,
            ),
          ],
          Container(
            width: 15,
            height: 15,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          SizedBox(
            width: 50,
            child: Text(
              _formatDuration(_recordingDuration),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            width: 13,
          ),
          if (widget.screenRecordingStatus == ScreenRecordingStatus.none) ...[
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  IconPath.playCircle,
                  fit: BoxFit.cover,
                ),
                onPressed: _onStartRecording,
              ),
            ),
          ] else ...[
            SizedBox(
              height: 24,
              width: 24,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  IconPath.stopCircle,
                ),
                onPressed: _onStopRecording,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (widget.screenRecordingStatus == ScreenRecordingStatus.none) {
      return '00:00';
    }

    if (duration == Duration.zero) {
      return '00:00';
    }

    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> _onStartRecording() async {
    await widget.onStartRecording();

    // Start the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingDuration += const Duration(seconds: 1);
      });
    });
  }

  Future<void> _onPauseRecording() async {
    await widget.onPauseRecording();

    // cancel the timer
    _timer?.cancel();
  }

  Future<void> _onResumeRecording() async {
    await widget.onResumeRecording();

    // resume the timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _recordingDuration += const Duration(seconds: 1);
        });
      }
    });
  }

  Future<void> _onStopRecording() async {
    await widget.onStopRecording();

    // Stop the timer
    _timer?.cancel();
    _timer = null;

    // update screen recording status
    setState(() {
      _recordingDuration = Duration.zero;
    });
  }
}

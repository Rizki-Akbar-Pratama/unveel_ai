import 'package:flutter/material.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/stf_shades_widget.dart';

class STFLivePage extends StatefulWidget {
  const STFLivePage({
    super.key,
  });

  @override
  State<STFLivePage> createState() => _STFLivePageState();
}

class _STFLivePageState extends State<STFLivePage> {
  late LiveStep step;

  bool _isShowShades = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    // default step
    step = LiveStep.photoSettings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiveWidget(
        liveStep: step,
        liveType: LiveType.liveCamera,
        body: _buildBody,
        onLiveStepChanged: (value) {
          if (value != step) {
            if (mounted) {
              setState(() {
                step = value;
              });
            }
          }
        },
      ),
    );
  }

  Widget get _buildBody {
    switch (step) {
      case LiveStep.photoSettings:
        return const SizedBox.shrink();
      case LiveStep.scanningFace:
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
        if (_isShowShades) {
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'SHOW SHADES',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onShowShades,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onShowShades() async {
    // show analysis results
    setState(() {
      _isShowShades = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                STFShadesWidget(),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowShades = false;
    });
  }
}

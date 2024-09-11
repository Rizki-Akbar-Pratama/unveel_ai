import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/extensions/live_step_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';
import '../../../../shared/widgets/clippers/face_clipper.dart';
import '../../../../shared/widgets/lives/bottom_copyright_widget.dart';
import '../../../../shared/widgets/lives/live_widget.dart';
import '../../../find_the_look/presentation/pages/ftl_live_page.dart';
import '../widgets/sa_analysis_results_widget.dart';
import '../widgets/sa_full_analysis_results_widget.dart';

class SALivePage extends StatefulWidget {
  const SALivePage({
    super.key,
  });

  @override
  State<SALivePage> createState() => _SALivePageState();
}

class _SALivePageState extends State<SALivePage> {
  late LiveStep step;

  bool _isShowAnalysisResults = false;
  bool _isShowFullAnalysisResults = false;

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
    Color? screenRecordBackrgoundColor;
    if (_isShowFullAnalysisResults) {
      screenRecordBackrgoundColor = Colors.black;
    }

    return Scaffold(
      body: LiveWidget(
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
        if (_isShowFullAnalysisResults) {
          return const SAFullAnalysisResultsWidget();
        }

        if (_isShowAnalysisResults) {
          return const BottomCopyrightWidget(
            child: SizedBox.shrink(),
          );
        }

        return BottomCopyrightWidget(
          child: Column(
            children: [
              ButtonWidget(
                text: 'ANALYSIS RESULT',
                width: context.width / 2,
                backgroundColor: Colors.black,
                onTap: _onAnalysisResults,
              ),
            ],
          ),
        );
      case LiveStep.makeup:
        return const SizedBox.shrink();
    }
  }

  Future<void> _onAnalysisResults() async {
    // show analysis results
    setState(() {
      _isShowAnalysisResults = true;
    });

    // show bottom sheet
    await showModalBottomSheet<bool?>(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      constraints: BoxConstraints(
        minHeight: context.height * 0.6,
        maxHeight: context.height * 0.8,
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(
            bottom: SizeConfig.bottomLiveMargin,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SAAnalysisResultsWidget(
                  onViewAll: () {
                    // close this dialog
                    context.pop();

                    _onViewAllProducts();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    // hide analysis results
    setState(() {
      _isShowAnalysisResults = false;
    });
  }

  void _onViewAllProducts() {
    setState(() {
      _isShowAnalysisResults = false;
      _isShowFullAnalysisResults = true;
    });
  }
}

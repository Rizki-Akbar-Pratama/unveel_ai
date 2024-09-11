import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/color_config.dart';
import '../../configs/size_config.dart';
import '../../extensions/context_parsing.dart';
import '../../extensions/live_configuration_step_parsing.dart';
import 'bottom_copyright_widget.dart';

class LiveConfigurationStepWidget extends StatelessWidget {
  final LiveConfigurationStep? liveConfigurationStep;

  const LiveConfigurationStepWidget({
    super.key,
    this.liveConfigurationStep,
  });

  @override
  Widget build(BuildContext context) {
    return BottomCopyrightWidget(
      topMargin: SizeConfig.appBarMargin,
      child: Column(
        children: [
          Text(
            _hintMessage ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          SizedBox(
            height: 36,
            child: ListView.separated(
              itemCount: LiveConfigurationStep.values.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
              ),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final step = LiveConfigurationStep.values[index];
                final width = context.width / 3.5;
                final isActive = step.isActive(
                  currentStep: liveConfigurationStep,
                );

                return _ItemWidget(
                  title: step.title,
                  iconPath: step.iconPath(
                    isActive: isActive,
                  ),
                  width: width,
                  isActive: isActive,
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  String? get _hintMessage {
    if (liveConfigurationStep == null) {
      return "Position the face at the center of the screen for best results";
    }

    switch (liveConfigurationStep!) {
      case LiveConfigurationStep.facePosition:
        return "Ensure the light source is in front of the face, not behind";
      case LiveConfigurationStep.lightning:
        return "Keep the face centered within the frame";
      case LiveConfigurationStep.orientation:
        return null;
    }
  }
}

class _ItemWidget extends StatefulWidget {
  final String title;
  final String iconPath;
  final bool isActive;
  final double width;

  const _ItemWidget({
    required this.title,
    required this.iconPath,
    required this.isActive,
    required this.width,
  });

  @override
  State<_ItemWidget> createState() => __ItemWidgetState();
}

class __ItemWidgetState extends State<_ItemWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      return Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: _buildChild,
      );
    }

    return SizedBox(
      width: widget.width,
      child: DottedBorder(
        radius: const Radius.circular(9),
        color: const Color(0xFF949494),
        borderType: BorderType.RRect,
        dashPattern: const [5, 5],
        padding: EdgeInsets.zero,
        child: _buildChild,
      ),
    );
  }

  Widget get _buildChild {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      height: context.height,
      decoration: BoxDecoration(
        gradient: widget.isActive ? ColorConfig.horizontalGradient : null,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AutoSizeText(
              widget.title,
              maxLines: 1,
              maxFontSize: 12,
              softWrap: false,
              style: TextStyle(
                color: widget.isActive ? Colors.white : const Color(0xFF949494),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          SvgPicture.asset(
            widget.iconPath,
            colorFilter: ColorFilter.mode(
              widget.isActive ? Colors.white : const Color(0xFF949494),
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

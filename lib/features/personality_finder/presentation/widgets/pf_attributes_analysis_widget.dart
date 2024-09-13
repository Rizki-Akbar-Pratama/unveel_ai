import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unveels/features/personality_finder/data/models/recognition.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/size_config.dart';
import '../../../../shared/extensions/context_parsing.dart';

class PFAttributesAnalysisWidget extends StatelessWidget {
  final List<Recognition>? recognition;
  const PFAttributesAnalysisWidget({super.key, required this.recognition});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: SizeConfig.horizontalPadding,
      ),
      child: Column(
        children: [
           _BodyItemWidget(
            title: "Face",
            iconPath: IconPath.face,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                value: recognition?[0].thickness, //_Reverse
              ),
            ],
            rightChildren: const [
              _DetailBodyItem(
                title: "Skin Tone",
                value: "Dark latte",
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Eyes",
            iconPath: IconPath.eye,
            leftChildren: [
              _DetailBodyItem(
                title: "Eye Shape",
                value: recognition?[0].eyeshape,
              ),
              _DetailBodyItem(
                title: "Eye Angle",
                value: recognition?[0].eyeangle,
              ),
               _DetailBodyItem(
                title: "Eyelid",
                value: recognition?[0].nosewidth, //_Reverse
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Eye Size",
                value: recognition?[0].eyesize,
              ),
              _DetailBodyItem(
                title: "Eye Distance",
                value: recognition?[0].eyedistance,
              ),
              _DetailBodyItem(
                title: "Eye Color",
                value: recognition?[0].eyeColor,
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Brows",
            iconPath: IconPath.brow,
            leftChildren: [
              _DetailBodyItem(
                title: "Eyebrow Shape",
                value: recognition?[0].noselength, //_Reverse
              ),
              _DetailBodyItem(
                title: "Eyebrow Distance",
                value: recognition?[0].eyebrowdistance,
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Thickness",
                value: recognition?[0].faceshape, //_Reverse
              ),
              _DetailBodyItem(
                title: "Eyebrow color",
                valueWidget: Container(
                  height: 28,
                  color: Color.fromARGB(recognition?[0].eyebrowColor['a'], recognition?[0].eyebrowColor['r'], recognition?[0].eyebrowColor['g'], recognition?[0].eyebrowColor['b']),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Lips",
            iconPath: IconPath.lip,
            leftChildren: [
              _DetailBodyItem(
                title: "Lip shape",
                value: recognition?[0].thinnes, //_Reverse
              ),
            ],
            rightChildren: [
              _DetailBodyItem(
                title: "Lip color",
                valueWidget: Container(
                  height: 28,
                  color: Color.fromARGB(recognition?[0].lipColor['a'], recognition?[0].lipColor['r'], recognition?[0].lipColor['g'], recognition?[0].lipColor['b']),
                ),
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Cheekbones",
            iconPath: IconPath.cheekbones,
            leftChildren: [
              _DetailBodyItem(
                title: "Cheekbones",
                value: recognition?[0].cheekbones,
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Nose",
            iconPath: IconPath.nose,
            leftChildren: [
              _DetailBodyItem(
                title: "Nose Shape",
                value: recognition?[0].eyelid, //_Reverse
              ),
            ],
          ),
          const Divider(
            height: 50,
          ),
          _BodyItemWidget(
            title: "Hair",
            iconPath: IconPath.hair,
            leftChildren: [
              _DetailBodyItem(
                title: "Face Shape",
                valueWidget: Container(
                  height: 28,
                  color: Color.fromARGB(recognition?[0].hairColor['a'], recognition?[0].hairColor['r'], recognition?[0].hairColor['g'], recognition?[0].hairColor['b']),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BodyItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const _BodyItemWidget({
    required this.iconPath,
    required this.title,
    this.leftChildren = const [],
    this.rightChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: leftChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return leftChildren[index];
                },
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.width * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: rightChildren.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return rightChildren[index];
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailBodyItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? valueWidget;

  const _DetailBodyItem({
    required this.title,
    this.value,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        if (valueWidget != null) ...[
          const SizedBox(
            height: 4,
          ),
          valueWidget!,
        ],
        if (value != null) ...[
          const SizedBox(
            height: 4,
          ),
          Text(
            "• $value",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}

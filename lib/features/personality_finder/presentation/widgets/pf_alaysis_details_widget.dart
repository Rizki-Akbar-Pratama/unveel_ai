import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';

class PFAnalysisDetailsWidget extends StatelessWidget {
  final String title;
  final String description;

  const PFAnalysisDetailsWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 40,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    IconPath.chevronDown,
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Severity",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Mild 40%",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConfig.greenSuccess,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

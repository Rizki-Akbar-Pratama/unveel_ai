import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/configs/color_config.dart';
import '../../../../shared/configs/size_config.dart';
import 'sa_product_item_widget.dart';

class SAAnalysisDetailsWidget extends StatefulWidget {
  final String title;

  const SAAnalysisDetailsWidget({
    super.key,
    required this.title,
  });

  @override
  State<SAAnalysisDetailsWidget> createState() =>
      _SAAnalysisDetailsWidgetState();
}

class _SAAnalysisDetailsWidgetState extends State<SAAnalysisDetailsWidget> {
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
                    widget.title,
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
                "Detected",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "Forehead: Mild spots observed, likely due to sun exposure.\nCheeks: A few dark spots noted on both cheeks, possibly post-inflammatory hyperpigmentation",
                style: TextStyle(
                  fontSize: 14,
                ),
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
              const Text(
                "Fine lines around eyes, forehead.\nHey there! As much as we embrace aging gracefully, those detected creases and lines can sneak up on us sooner than we'd like. To fend off those pesky wrinkles, remember to stay hydrated and wear sunscreen daily. Adding a skin-nourishing routine can work wonders. Embrace your lines, but there's no harm in giving them a little extra tender loving care by checking our recommendations to keep them at bay for as long as possible. Your future self will thank you and us for the care!",
                style: TextStyle(
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Recommended products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 10,
              );
            },
            itemBuilder: (context, index) {
              final isFirst = index == 0;
              final isEnd = index == 10 - 1;

              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? SizeConfig.horizontalPadding : 0,
                  right: isEnd ? SizeConfig.horizontalPadding : 0,
                ),
                child: const SAProductItemWidget(),
              );
            },
          ),
        ),
      ],
    );
  }
}

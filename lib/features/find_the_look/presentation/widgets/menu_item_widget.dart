import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../shared/configs/asset_path.dart';
import '../../../../shared/extensions/context_parsing.dart';
import '../../../../shared/widgets/buttons/button_widget.dart';

class MenuItemWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;
  final List<String> steps;
  final String buttonText;
  final Function() onTap;

  const MenuItemWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.steps,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 26,
      ),
      childrenPadding: const EdgeInsets.fromLTRB(
        26,
        0,
        26,
        20,
      ),
      trailing: const SizedBox.shrink(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      backgroundColor: const Color(0xFF151515),
      collapsedBackgroundColor: const Color(0xFF151515),
      title: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      subtitle: SizedBox(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    IconPath.chevronDown,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Expanded(
                    child: Text(
                      "Steps to Follow",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: steps.length,
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final step = steps[index];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "• ",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          step,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        ButtonWidget(
          text: buttonText,
          width: context.width,
          onTap: onTap,
        ),
      ],
    );
  }
}

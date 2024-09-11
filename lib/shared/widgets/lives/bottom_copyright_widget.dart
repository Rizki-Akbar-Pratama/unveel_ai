import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../configs/asset_path.dart';
import '../../configs/size_config.dart';

class BottomCopyrightWidget extends StatelessWidget {
  final double? topMargin;
  final Widget child;

  const BottomCopyrightWidget({
    super.key,
    this.topMargin,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        margin: EdgeInsets.only(
          top: topMargin ?? 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            child,
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Powered by",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                SvgPicture.asset(
                  IconPath.unveelsLogo,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.bottomPadding,
            ),
          ],
        ),
      ),
    );
  }
}

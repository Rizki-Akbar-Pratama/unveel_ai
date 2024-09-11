import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../configs/asset_path.dart';
import '../../configs/color_config.dart';
import '../../configs/size_config.dart';
import '../buttons/button_widget.dart';

class ShareVideoBottomSheet {
  const ShareVideoBottomSheet._();

  static Future<bool?> show({
    required BuildContext context,
    required XFile video,
  }) async {
    return await showModalBottomSheet<bool?>(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.horizontalPadding,
            vertical: 20,
          ),
          child: SafeArea(
            bottom: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ButtonWidget(
                        text: 'Exit',
                        backgroundColor: Colors.transparent,
                        textColor: Colors.white,
                        borderColor: ColorConfig.primary,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // close this dialog
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ButtonWidget(
                        backgroundColor: ColorConfig.primary,
                        textColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Share',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SvgPicture.asset(
                              IconPath.share,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                        onTap: () async {
                          // share the recorded video
                          final shared = await Share.shareXFiles(
                            [video],
                          );

                          if (shared.status == ShareResultStatus.success) {
                            // close this dialog
                            Navigator.of(context).pop(true);
                          }
                        },
                      ),
                    ),
                  ],
                ),
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
      },
    );
  }
}

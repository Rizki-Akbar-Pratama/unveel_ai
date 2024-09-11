import 'package:flutter/material.dart';

import '../../configs/color_config.dart';
import '../../extensions/context_parsing.dart';
import '../../extensions/string_parsing.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  final String? message;

  const FullScreenLoadingWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SizedBox(
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 130,
              width: 130,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: ColorConfig.primary,
                      strokeWidth: 2.5,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    message ?? "${context.locale.loading.toCapitalize()}...",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

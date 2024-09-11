import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_config.dart';
import 'text_style_config.dart';

class ThemeConfig {
  static ThemeData get dark {
    final baseTheme = ThemeData.dark();

    return ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.latoTextTheme(baseTheme.textTheme),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ColorConfig.primary,
      ),
      appBarTheme: baseTheme.appBarTheme.copyWith(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        titleTextStyle: TextStyleConfig.title4.copyWith(
          color: Colors.white,
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
      ),
      dividerTheme: baseTheme.dividerTheme.copyWith(
        color: ColorConfig.divider,
        thickness: 1,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light(
        surfaceTint: Colors.white,
      ),
      useMaterial3: true,
    );
  }
}

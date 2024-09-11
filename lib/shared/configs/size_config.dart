import 'dart:io';

import 'package:flutter/foundation.dart';

class SizeConfig {
  static double get horizontalPadding {
    if (kIsWeb) {
      return 20;
    }

    if (Platform.isAndroid) {
      return 20;
    } else if (Platform.isIOS) {
      return 20;
    }

    return 20;
  }

  static double get topPadding {
    if (kIsWeb) {
      return 20;
    }

    if (Platform.isAndroid) {
      return 20;
    } else if (Platform.isIOS) {
      return 20;
    }

    return 20;
  }

  static double get bottomPadding {
    if (kIsWeb) {
      return 20;
    }

    if (Platform.isAndroid) {
      return 20;
    } else if (Platform.isIOS) {
      return 20;
    }

    return 20;
  }

  static double get bottomSheetButtonBottomPadding {
    if (kIsWeb) {
      return 20;
    }

    if (Platform.isAndroid) {
      return 100;
    } else if (Platform.isIOS) {
      return 100;
    }

    return 100;
  }

  static double get maxImageSizeInMb {
    return 0.3;
  }

  static double get maxImageSizeInKb {
    return maxImageSizeInMb * 1024;
  }

  static int get imageQuality {
    return 50;
  }

  static const double appBarMargin = 120;

  static const double bottomLiveMargin = 60;
}

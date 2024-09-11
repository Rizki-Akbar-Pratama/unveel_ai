import 'package:flutter/material.dart';

import '../configs/color_config.dart';

enum ToastType {
  error,
  success,
  warning,
}

extension ToastTypeParsing on ToastType {
  Color get backgroundColor {
    switch (this) {
      case ToastType.error:
        return ColorConfig.redError;
      case ToastType.success:
        return ColorConfig.greenSuccess;
      case ToastType.warning:
        return ColorConfig.yellowPending;
    }
  }

  dynamic get webBackgroundColor {
    switch (this) {
      case ToastType.error:
        return "linear-gradient(to right, #ff0000, #ff0000)";
      case ToastType.success:
        return "linear-gradient(to right, #00b09b, #96c93d)";
      case ToastType.warning:
        return "linear-gradient(to right, #ffcc00, #ffcc00)";
    }
  }

  Color get textColor {
    switch (this) {
      case ToastType.error:
        return Colors.white;
      case ToastType.success:
        return Colors.white;
      case ToastType.warning:
        return Colors.white;
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/extensions/toast_type_parsing.dart';

abstract class ToastInfo {
  Future<void> showToast({
    required ToastType type,
    required String message,
  });
}

class ToastInfoImpl implements ToastInfo {
  @override
  Future<void> showToast({
    required ToastType type,
    required String message,
  }) async {
    // cancel all toasts before showing a new one
    await _cancelAllToasts();

    // show toast
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      backgroundColor: type.backgroundColor,
      textColor: type.textColor,
      fontSize: 16.0,
      webBgColor: type.webBackgroundColor,
    );
  }

  Future<void> _cancelAllToasts() async {
    if (kIsWeb) {
      return;
    }

    await Fluttertoast.cancel();
  }
}

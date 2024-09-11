import 'package:flutter/material.dart';

class KeyboardInfo {
  // close keyboard
  static void close(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
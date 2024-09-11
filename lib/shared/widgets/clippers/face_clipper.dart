import 'package:flutter/material.dart';

class FaceClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width - size.width * 0.2,
      height: size.height,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

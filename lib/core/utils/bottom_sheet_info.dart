import 'package:flutter/material.dart';

abstract class BottomSheetInfo {
  Future<T> showMaterialModal<T>({
    required BuildContext context,
    Color? backgroundColor,
    required Widget child,
    bool? isDismissible,
    bool? enableDrag,
  });
}

class BottomSheetInfoImpl implements BottomSheetInfo {
  @override
  Future<T> showMaterialModal<T>({
    required BuildContext context,
    Color? backgroundColor,
    required Widget child,
    bool? isDismissible,
    bool? enableDrag,
    double? maxHeight,
  }) async {
    return await showModalBottomSheet(
      context: context,
      backgroundColor: backgroundColor ?? Colors.white,
      isDismissible: isDismissible ?? true,
      enableDrag: enableDrag ?? true,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0.5),
      // duration: const Duration(milliseconds: 250),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        );
      },
    );
  }
}

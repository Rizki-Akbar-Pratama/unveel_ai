import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bottom_sheet_info.dart';
import '../../service_locator.dart';
import '../widgets/loadings/cubit/full_screen_loading/full_screen_loading_cubit.dart';

extension ContextParsing on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  Size get size => mediaQueryData.size;

  double get height => size.height;

  double get width => size.width;

  double get paddingTop => mediaQueryData.padding.top;

  double get paddingBottom => mediaQueryData.padding.bottom;

  double get phoneHeightWihtoutSafeArea {
    return height - paddingTop - paddingBottom;
  }

  double get viewInsetsBottom => mediaQueryData.viewInsets.bottom;

  void get closeKeyboard {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  Future<T?> showDialog<T>({
    required Widget child,
    bool? isDismissible,
    bool? enableDrag,
  }) async {
    // if (kIsWeb) {
    //   return await sl<DialogInfo>().show(
    //     context: this,
    //     child: child,
    //   );
    // }

    return await sl<BottomSheetInfo>().showMaterialModal(
      context: this,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      child: child,
    );
  }

  void showFullScreenLoading({
    String? message,
  }) {
    BlocProvider.of<FullScreenLoadingCubit>(this).show(
      message: message,
    );
  }

  void get hideFullScreenLoading {
    BlocProvider.of<FullScreenLoadingCubit>(this).hide();
  }

  bool? get isFirstRoute {
    return ModalRoute.of(this)?.isFirst;
  }

  AppLocalizations get locale {
    var AppLocalizations;
    return AppLocalizations.of(this)!;
  }
}

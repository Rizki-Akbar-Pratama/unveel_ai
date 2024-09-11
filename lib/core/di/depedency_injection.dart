import '../../service_locator.dart';
import '../routers/app_route_info.dart';
import '../utils/bottom_sheet_info.dart';
import '../utils/directory_info.dart';
import '../utils/local_picker_info.dart';
import '../utils/permission_info.dart';
import '../utils/toast_info.dart';

class CoreDI {
  static void init() {
    // app route info
    sl.registerLazySingleton<AppRouteInfo>(() {
      return AppRouteInfoImpl();
    });

    // bottom sheet
    sl.registerLazySingleton<BottomSheetInfo>(() {
      return BottomSheetInfoImpl();
    });

    // toast info
    sl.registerLazySingleton<ToastInfo>(() {
      return ToastInfoImpl();
    });

    // image picker info
    sl.registerLazySingleton<LocalPickerInfo>(() {
      return LocalPickerInfoImpl(
        imagePicker: sl(),
      );
    });

    // directory info
    sl.registerLazySingleton<DirectoryInfo>(() {
      return const DirectoryInfoImpl();
    });

    // permission info
    sl.registerLazySingleton<PermissionInfo>(() {
      return PermissionInfoImpl();
    });
  }
}

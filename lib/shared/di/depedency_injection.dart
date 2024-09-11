import '../../service_locator.dart';
import '../widgets/loadings/cubit/full_screen_loading/full_screen_loading_cubit.dart';

class SharedDI {
  static void init() {
    // full screen loading cubit
    sl.registerFactory<FullScreenLoadingCubit>(() {
      return FullScreenLoadingCubit();
    });
  }
}

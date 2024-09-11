import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'core/di/depedency_injection.dart';
import 'features/find_the_look/di/depedency_injection.dart';
import 'features/shop_the_look/di/depedency_injection.dart';
import 'shared/di/depedency_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  _external();

  CoreDI.init();

  SharedDI.init();

  FindTheLookDI.init();

  ShopTheLookDI.init();
}

void _external() {
  // Image Picker
  sl.registerLazySingleton<ImagePicker>(() {
    return ImagePicker();
  });
}

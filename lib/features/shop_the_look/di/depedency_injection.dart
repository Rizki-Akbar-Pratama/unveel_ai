import '../../../service_locator.dart';
import '../presentation/cubit/product_cart/product_cart_cubit.dart';

class ShopTheLookDI {
  static void init() {
    // register cubits
    _registerCubits();
  }

  static void _registerCubits() {
    sl.registerFactory<ProductCartCubit>(() {
      return ProductCartCubit();
    });
  }
}

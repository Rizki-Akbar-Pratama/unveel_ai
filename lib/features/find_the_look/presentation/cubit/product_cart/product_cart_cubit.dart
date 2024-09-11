import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_cart_state.dart';

class ProductCartCubit extends Cubit<ProductCartState> {
  ProductCartCubit() : super(ProductCartInitial());

  void addProduct() {
    final currentState = state;

    if (currentState is ProductCartLoaded) {
      final products = List<int>.from(currentState.products);
      products.add(products.length + 1);

      emit(ProductCartLoaded(products: products));
    } else {
      emit(const ProductCartLoaded(products: [1]));
    }
  }

  void removeProduct() {
    try {
      final currentState = state;

      if (currentState is ProductCartLoaded) {
        final products = List<int>.from(currentState.products);
        if (products.length < 2) {
          throw "Cannot delete All Products.";
        }

        products.remove(products.length);

        emit(ProductCartLoaded(products: products));
      }
    } catch (_) {
      rethrow;
    }
  }
}

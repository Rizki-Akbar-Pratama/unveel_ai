part of 'product_cart_cubit.dart';

sealed class ProductCartState extends Equatable {
  const ProductCartState();

  @override
  List<Object> get props => [];
}

final class ProductCartInitial extends ProductCartState {}

final class ProductCartLoading extends ProductCartState {}

final class ProductCartLoaded extends ProductCartState {
  final List<int> products;

  const ProductCartLoaded({
    required this.products,
  });

  ProductCartLoaded copyWith({
    List<int>? products,
  }) {
    return ProductCartLoaded(
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [products];
}

final class ProductCartError extends ProductCartState {
  final Object error;

  const ProductCartError({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

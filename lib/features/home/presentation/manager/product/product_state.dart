import 'package:equatable/equatable.dart';

import '../../../domain/entities/product/product_entity.dart';

abstract class ProductState extends Equatable {
  final List<ProductEntity> products;
  final bool hasReachedMax;

  const ProductState({
    required this.products,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductInitial extends ProductState {
  const ProductInitial() : super(products: const [], hasReachedMax: false);
}

class ProductLoading extends ProductState {
  const ProductLoading({
    required super.products,
    required super.hasReachedMax,
  });
}

class ProductLoaded extends ProductState {
  const ProductLoaded({
    required super.products,
    required super.hasReachedMax,
  });
}

class ProductError extends ProductState {
  final String message;

  const ProductError(
    this.message, {
    required super.products,
    required super.hasReachedMax,
  });

  @override
  List<Object?> get props => [message, products, hasReachedMax];
}

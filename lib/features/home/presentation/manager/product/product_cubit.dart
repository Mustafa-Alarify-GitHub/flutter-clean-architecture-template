import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/mixin/cancelable_safe_cubit_mixin.dart';
import '../../../../../shared/models/pagination/pagination_params.dart';
import '../../../domain/entities/product/product_entity.dart';
import '../../../domain/usecases/get_product_usecase.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState>
    with CancelableSafeCubitMixin<ProductState> {
  final GetProductUseCase getProductUseCase;

  ProductCubit(this.getProductUseCase) : super(const ProductInitial());

  Future<void> loadProducts({int limit = 10, bool isRefresh = false}) async {
    final currentProducts = isRefresh ? <ProductEntity>[] : state.products;
    final currentlyReachedMax = isRefresh ? false : state.hasReachedMax;

    if (currentlyReachedMax) {
      return;
    }

    safeEmit(ProductLoading(
      products: currentProducts,
      hasReachedMax: currentlyReachedMax,
    ));

    final result = await runCancelable(
      getProductUseCase.call(
        PaginationParams(skip: currentProducts.length, limit: limit),
      ),
    );

    if (result == null) {
      return;
    }

    result.fold(
      (failure) {
        safeEmit(ProductError(
          failure.message,
          products: currentProducts,
          hasReachedMax: currentlyReachedMax,
        ));
      },
      (newProducts) {
        final allProducts = List<ProductEntity>.from(currentProducts)..addAll(newProducts);
        final reachedMax = newProducts.isEmpty || newProducts.length < limit;

        safeEmit(ProductLoaded(
          products: allProducts,
          hasReachedMax: reachedMax,
        ));
      },
    );
  }
}

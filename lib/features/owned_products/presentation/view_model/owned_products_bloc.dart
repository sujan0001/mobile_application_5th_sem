import 'package:batch34_b/features/owned_products/domain/use_case/get_my_owned_products_usecase.dart';
import 'package:batch34_b/features/owned_products/domain/use_case/resell_product_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'owned_products_event.dart';
import 'owned_products_state.dart';

class OwnedProductsBloc extends Bloc<OwnedProductsEvent, OwnedProductsState> {
  final GetMyOwnedProductsUseCase _getMyOwnedProductsUseCase;
  final ResellProductUseCase _resellProductUseCase;

  OwnedProductsBloc({
    required GetMyOwnedProductsUseCase getMyOwnedProductsUseCase,
    required ResellProductUseCase resellProductUseCase,
  })  : _getMyOwnedProductsUseCase = getMyOwnedProductsUseCase,
        _resellProductUseCase = resellProductUseCase,
        super(OwnedProductsInitial()) {
    on<GetMyOwnedProductsEvent>(_onGetMyOwnedProducts);
    on<ResellProductEvent>(_onResellProduct);
  }

  void _onGetMyOwnedProducts(
    GetMyOwnedProductsEvent event,
    Emitter<OwnedProductsState> emit,
  ) async {
    emit(OwnedProductsLoading());
    
    final result = await _getMyOwnedProductsUseCase();
    result.fold(
      (failure) => emit(OwnedProductsError(failure.message)), // Changed from failure.error to failure.message
      (products) => emit(OwnedProductsLoaded(products)),
    );
  }

  void _onResellProduct(
    ResellProductEvent event,
    Emitter<OwnedProductsState> emit,
  ) async {
    emit(ResellProductLoading());
    
    final result = await _resellProductUseCase(event.productId, event.resalePrice);
    result.fold(
      (failure) => emit(ResellProductError(failure.message)), // Changed from failure.error to failure.message
      (message) {
        emit(ResellProductSuccess(message));
        // Refresh the products list after successful resell
        add(GetMyOwnedProductsEvent());
      },
    );
  }
}
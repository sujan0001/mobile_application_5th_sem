import 'package:batch34_b/core/common/snackbar/my_snack_bar.dart';
import 'package:batch34_b/features/s_marketplace/domain/usecase/get_sold_products_usecase.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SMarketplaceViewModel extends Bloc<SMarketplaceEvent, SMarketplaceState> {
  final GetSoldProductsUsecase _getSoldProductsUsecase;

  SMarketplaceViewModel(this._getSoldProductsUsecase) 
      : super(const SMarketplaceState.initial()) {
    on<LoadSoldProductsEvent>(_onLoadSoldProducts);
    on<RefreshSoldProductsEvent>(_onRefreshSoldProducts);
    on<NavigateToProductDetailsEvent>(_onNavigateToProductDetails);
  }

  Future<void> _onLoadSoldProducts(
    LoadSoldProductsEvent event,
    Emitter<SMarketplaceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _getSoldProductsUsecase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (soldProductsResponse) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          soldProducts: soldProductsResponse.data,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _onRefreshSoldProducts(
    RefreshSoldProductsEvent event,
    Emitter<SMarketplaceState> emit,
  ) async {
    // For refresh, we don't show loading indicator
    final result = await _getSoldProductsUsecase();

    result.fold(
      (failure) {
        emit(state.copyWith(
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (soldProductsResponse) {
        emit(state.copyWith(
          isSuccess: true,
          soldProducts: soldProductsResponse.data,
          errorMessage: null,
        ));
      },
    );
  }

  void _onNavigateToProductDetails(
    NavigateToProductDetailsEvent event,
    Emitter<SMarketplaceState> emit,
  ) {
    // Find the product from current state
    final product = state.soldProducts.firstWhere(
      (p) => p.id == event.productId,
      orElse: () => throw Exception('Product not found'),
    );

    // Navigate to product details page
    // You'll need to create the ProductDetailsView
    /*
    Navigator.push(
      event.context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: serviceLocator<ProductDetailsViewModel>(),
          child: ProductDetailsView(product: product),
        ),
      ),
    );
    */
    
    // For now, show a snackbar
    showMySnackBar(
      context: event.context,
      message: 'Navigating to ${product.name} details',
    );
  }

  // Example: Additional event handlers you might need
  /*
  Future<void> _onBuyProduct(
    BuyProductEvent event,
    Emitter<SMarketplaceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _buyProductUsecase(BuyProductParams(productId: event.productId));

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
      (product) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: 'Product purchased successfully!',
        );
        // Refresh the sold products list
        add(LoadSoldProductsEvent());
      },
    );
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<SMarketplaceState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _searchProductsUsecase(SearchProductsParams(query: event.query));

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (products) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          soldProducts: products,
          errorMessage: null,
        ));
      },
    );
  }
  */
}
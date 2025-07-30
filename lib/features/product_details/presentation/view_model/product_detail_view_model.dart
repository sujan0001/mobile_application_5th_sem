import 'package:batch34_b/features/product_details/domain/use_case/get_product_by_id_use_case.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_event.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailViewModel extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductDetailViewModel({
    required GetProductByIdUseCase getProductByIdUseCase,
  }) : _getProductByIdUseCase = getProductByIdUseCase,
       super(ProductDetailInitialState()) {
    
    on<LoadProductDetailEvent>(_onLoadProductDetail);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetailEvent event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoadingState());

    final result = await _getProductByIdUseCase(event.productId);

    result.fold(
      (error) => emit(ProductDetailErrorState(message: error)),
      (product) => emit(ProductDetailLoadedState(product: product)),
    );
  }
}

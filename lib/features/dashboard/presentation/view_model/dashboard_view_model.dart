// dashboard_view_model.dart
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardViewModel extends Bloc<DashboardEvent, DashboardState> {
  final GetAllCollectionsUseCase getAllCollectionsUseCase;
  final GetAvailableProductsUseCase getAvailableProductsUseCase;
  final GetAllCreatorsUseCase getAllCreatorsUseCase;

  DashboardViewModel({
    required this.getAllCollectionsUseCase,
    required this.getAvailableProductsUseCase,
    required this.getAllCreatorsUseCase,
  }) : super(const DashboardState.initial()) {
    on<LoadDashboardDataEvent>(_onLoadDashboardData);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    print('🔥 LoadDashboardDataEvent received');
    print('🔥 Current state: isLoading=${state.isLoading}, collections=${state.collections.length}, products=${state.products.length}, creators=${state.creators.length}');
    
    emit(state.copyWith(isLoading: true));
    print('🔥 Loading state emitted');

    try {
      print('🔥 Calling getAllCollectionsUseCase...');
      final collectionResult = await getAllCollectionsUseCase();
      print('🔥 Collections result: ${collectionResult.toString()}');
      
      print('🔥 Calling getAvailableProductsUseCase...');
      final productResult = await getAvailableProductsUseCase();
      print('🔥 Products result: ${productResult.toString()}');
      
      print('🔥 Calling getAllCreatorsUseCase...');
      final creatorResult = await getAllCreatorsUseCase();
      print('🔥 Creators result: ${creatorResult.toString()}');

      final collections = collectionResult.getOrElse(() => []);
      final products = productResult.getOrElse(() => []);
      final creators = creatorResult.getOrElse(() => []);

      print('🔥 Final data: collections=${collections.length}, products=${products.length}, creators=${creators.length}');

      emit(state.copyWith(
        isLoading: false,
        collections: collections,
        products: products,
        creators: creators,
      ));
      
      print('🔥 Final state emitted');
    } catch (e) {
      print('🔥 Error in _onLoadDashboardData: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
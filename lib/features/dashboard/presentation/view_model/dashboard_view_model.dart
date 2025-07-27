
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
    emit(state.copyWith(isLoading: true));

    final collectionResult = await getAllCollectionsUseCase();
    final productResult = await getAvailableProductsUseCase();
    final creatorResult = await getAllCreatorsUseCase();

    emit(state.copyWith(
      isLoading: false,
      collections: collectionResult.getOrElse(() => []),
      products: productResult.getOrElse(() => []),
      creators: creatorResult.getOrElse(() => []),
    ));
  }
}

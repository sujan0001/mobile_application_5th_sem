
import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/core/network/hive_service.dart';
import 'package:batch34_b/features/auth/data/data_source/local_datasource/user_local_data_source.dart';
import 'package:batch34_b/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:batch34_b/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:batch34_b/features/auth/data/repository/remote_repository/user_remote_repository.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

import 'package:batch34_b/features/dashboard/data/data_source/remote_data_source/dashboard_remote_data_source.dart';
import 'package:batch34_b/features/dashboard/data/repository/remote_repository/dashboard_remote_repository_impl.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/navigation/view_model/navigation_cubit.dart';
import 'package:batch34_b/features/owned_products/data/data_source/owned_products_remote_data_source.dart';
import 'package:batch34_b/features/owned_products/data/data_source/remote_datasource/owned_products_remote_data_source_impl.dart';
import 'package:batch34_b/features/owned_products/data/repository/remote_repository/owned_products_remote_repository.dart';
import 'package:batch34_b/features/owned_products/domain/repository/owned_products_repository.dart';
import 'package:batch34_b/features/owned_products/domain/use_case/get_my_owned_products_usecase.dart';
import 'package:batch34_b/features/owned_products/domain/use_case/resell_product_usecase.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_bloc.dart';
import 'package:batch34_b/features/permission_creator/data/data_source/remote_datasource/transfer_request_remote_datasource_impl.dart';
import 'package:batch34_b/features/permission_creator/data/data_source/transfer_request_remote_datasource.dart';
import 'package:batch34_b/features/permission_creator/data/repository/remote_repository/transfer_request_repository_impl.dart';
import 'package:batch34_b/features/permission_creator/domain/repository/transfer_request_repository.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/get_incoming_transfer_requests.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/respond_to_transfer_request.dart';
import 'package:batch34_b/features/permission_creator/presentation/view_model/permission_creator_view_model.dart';
import 'package:batch34_b/features/product_details/data/data_source/product_detail_remote_data_source.dart';
import 'package:batch34_b/features/product_details/data/data_source/remote_datasource/product_detail_remote_data_source_impl.dart';
import 'package:batch34_b/features/product_details/data/repository/remote_repository/product_detail_remote_repository.dart';
import 'package:batch34_b/features/product_details/domain/repository/product_detail_repository.dart';
import 'package:batch34_b/features/product_details/domain/use_case/get_product_by_id_use_case.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_view_model.dart';
import 'package:batch34_b/features/profile/presentation/view_model/profile_view_model.dart';
import 'package:batch34_b/features/s_marketplace/data/data_source/remote_data_source/request_transfer_remote_datasource_impl.dart';

import 'package:batch34_b/features/s_marketplace/data/data_source/remote_data_source/s_marketplace_remote_data_source.dart';
import 'package:batch34_b/features/s_marketplace/data/data_source/request_transfer_datasource.dart';
import 'package:batch34_b/features/s_marketplace/data/repository/remote_repository/request_transfer_repository_impl.dart';
import 'package:batch34_b/features/s_marketplace/data/repository/remote_repository/s_marketplace_remote_repository.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/request_transfer_repository.dart';
import 'package:batch34_b/features/s_marketplace/domain/repository/s_marketplace_repository.dart';
import 'package:batch34_b/features/s_marketplace/domain/usecase/get_sold_products_usecase.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:batch34_b/features/s_marketplace/domain/usecase/request_product_transfer_usecase.dart';

// Create a global instance of GetIt
final serviceLocator = GetIt.instance;

// Main initialization function
Future<void> initDependencies() async {
  // Registering services that need to be available as soon as the app starts
  await _initCoreServices();
  
  // Registering feature-specific dependencies
  _initAuthModule();
  _initSplashModule();
  //for dashboard service locator
  _initDashboardModule();
  //for s_marketplace service locator
  _initSMarketplaceModule();
  //for request transfer functionality
  _initRequestTransferModule();
  //for get permission functionality
  _initPermissionCreatorModule();
  //for my owned products
  _initOwnedProductsModule();
  //for get product by id
  _initProductDetailModule();
  //for profile
  _initProfileModule();

}

// Private helper to register all core services
Future<void> _initCoreServices() async {
  // Dio and ApiService for networking
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));

  // HiveService for local database
  serviceLocator.registerLazySingleton(() => HiveService());
  
  // SharedPreferences and Token handler for local key-value storage
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(
    () => TokenSharedPrefs(sharedPreferences: serviceLocator<SharedPreferences>()),
  );
  // Add this line in _initCoreServices() after TokenSharedPrefs registration
  serviceLocator.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
}

// Private helper to register all dependencies for the Authentication feature
void _initAuthModule() {
  // Data sources
  // A new instance will be created every time it's requested
  serviceLocator.registerFactory<UserRemoteDataSource>(
    () => UserRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );
  serviceLocator.registerFactory<UserLocalDataSource>(
    () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // Repositories
  // We register UserRemoteRepository as the implementation for IUserRepository.
  // This means whenever we ask for an IUserRepository, GetIt will provide a UserRemoteRepository.
  // This makes it easy to switch to UserLocalRepository for testing or offline mode.
  serviceLocator.registerFactory<IUserRepository>(
    () => UserRemoteRepository(
      userRemoteDataSource: serviceLocator<UserRemoteDataSource>(),
    ),
  );
  // We also register the local repository if we need to access it directly somewhere.
   serviceLocator.registerFactory<UserLocalRepository>(
    () => UserLocalRepository(
      userLocalDataSource: serviceLocator<UserLocalDataSource>(),
    ),
  );

  // Use cases
  serviceLocator.registerFactory<UserRegisterUsecase>(
    () => UserRegisterUsecase(userRepository: serviceLocator<IUserRepository>()),
  );
  serviceLocator.registerFactory<UserLoginUsecase>(
    () => UserLoginUsecase(
      userRepository: serviceLocator<IUserRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // ViewModels (Blocs)
  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<UserRegisterUsecase>()),
  );
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

// Private helper to register dependencies for the Splash feature
void _initSplashModule() {
  // Since we opted for a simplified View/ViewModel approach,
  // we only need to register the SplashViewModel.
  serviceLocator.registerFactory<SplashViewModel>(
    // It directly depends on TokenSharedPrefs to check the login status.
    () => SplashViewModel(serviceLocator<TokenSharedPrefs>()),
  );
}

//service locator for dashboard starts here:========================================

void _initDashboardModule() {
  // Data Source
  serviceLocator.registerFactory<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory<IDashboardRepository>(
    () => DashboardRemoteRepositoryImpl(
      dashboardDataSource: serviceLocator<DashboardRemoteDataSource>(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory<GetAllCollectionsUseCase>(
    () => GetAllCollectionsUseCase(
      serviceLocator<IDashboardRepository>(),
    ),
  );

  serviceLocator.registerFactory<GetAvailableProductsUseCase>(
    () => GetAvailableProductsUseCase(
      serviceLocator<IDashboardRepository>(),
    ),
  );

  serviceLocator.registerFactory<GetAllCreatorsUseCase>(
    () => GetAllCreatorsUseCase(
      serviceLocator<IDashboardRepository>(),
    ),
  );

  // ViewModel (Bloc / Cubit)
  serviceLocator.registerFactory<DashboardViewModel>(
  () => DashboardViewModel(
    getAllCollectionsUseCase: serviceLocator<GetAllCollectionsUseCase>(),
    getAvailableProductsUseCase: serviceLocator<GetAvailableProductsUseCase>(),
    getAllCreatorsUseCase: serviceLocator<GetAllCreatorsUseCase>(),
  ),
);
}

//service locator for s_marketplace starts here:===================================

void _initSMarketplaceModule() {
  // Data Source
  serviceLocator.registerFactory<SMarketplaceRemoteDataSource>(
    () => SMarketplaceRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory<ISMarketplaceRepository>(
    () => SMarketplaceRemoteRepository(
      sMarketplaceRemoteDataSource: serviceLocator<SMarketplaceRemoteDataSource>(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory<GetSoldProductsUsecase>(
    () => GetSoldProductsUsecase(
      sMarketplaceRepository: serviceLocator<ISMarketplaceRepository>(),
    ),
  );

  // ViewModel (Bloc)
  serviceLocator.registerFactory<SMarketplaceViewModel>(
    () => SMarketplaceViewModel(
      serviceLocator<GetSoldProductsUsecase>(),
    ),
  );
}

//service locator for request transfer functionality:===========================

void _initRequestTransferModule() {
  // Data Source - using your existing implementation
  serviceLocator.registerFactory<IRequestTransferDataSource>(
    () => RequestTransferRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<RequestTransferRepository>(
    () => RequestTransferRepositoryImpl(
      remoteDataSource: serviceLocator<IRequestTransferDataSource>(),
    ),
  );

  // UseCase
  serviceLocator.registerFactory<RequestProductTransferUseCase>(
    () => RequestProductTransferUseCase(
      repository: serviceLocator<RequestTransferRepository>(),
    ),
  );

  // Cubit
  serviceLocator.registerFactory<RequestTransferCubit>(
    () => RequestTransferCubit(
      requestProductTransferUseCase: serviceLocator<RequestProductTransferUseCase>(),
    ),
  );
}

// service locator for permission permission_creator===========================================

void _initPermissionCreatorModule() {
  // Data Source - using your existing Dio and TokenSharedPrefs implementation
  serviceLocator.registerFactory<TransferRequestRemoteDataSource>(
    () => TransferRequestRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<TransferRequestRepository>(
    () => TransferRequestRepositoryImpl(
      remoteDataSource: serviceLocator<TransferRequestRemoteDataSource>(),
    ),
  );

  // Use cases
  serviceLocator.registerFactory<GetIncomingTransferRequests>(
    () => GetIncomingTransferRequests(
      repository: serviceLocator<TransferRequestRepository>(),
    ),
  );

  serviceLocator.registerFactory<RespondToTransferRequest>(
    () => RespondToTransferRequest(
      repository: serviceLocator<TransferRequestRepository>(),
    ),
  );

  // ViewModel
  serviceLocator.registerFactory<PermissionCreatorViewModel>(
    () => PermissionCreatorViewModel(
      getIncomingTransferRequests: serviceLocator<GetIncomingTransferRequests>(),
      respondToTransferRequest: serviceLocator<RespondToTransferRequest>(),
    ),
  );
}

// OWNED products service locator starts here============================================================

void _initOwnedProductsModule() {
  // Data Source
  serviceLocator.registerLazySingleton<OwnedProductsRemoteDataSource>(
    () => OwnedProductsRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Repository
  serviceLocator.registerLazySingleton<OwnedProductsRepository>(
    () => OwnedProductsRemoteRepository(
      ownedProductsRemoteDataSource: serviceLocator<OwnedProductsRemoteDataSource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerLazySingleton<GetMyOwnedProductsUseCase>(
    () => GetMyOwnedProductsUseCase(serviceLocator<OwnedProductsRepository>()
    ),
  );
  serviceLocator.registerLazySingleton<ResellProductUseCase>(
    () => ResellProductUseCase(serviceLocator<OwnedProductsRepository>()),
  );

  // ViewModel (Bloc)
  serviceLocator.registerFactory<OwnedProductsBloc>(
    () => OwnedProductsBloc(
      getMyOwnedProductsUseCase: serviceLocator<GetMyOwnedProductsUseCase>(),
      resellProductUseCase: serviceLocator<ResellProductUseCase>(),
    ),
  );
}

// get product by id service locator=======================================================

void _initProductDetailModule() {
  // Data Source - using Dio and TokenSharedPrefs directly like your other modules
  serviceLocator.registerFactory<ProductDetailRemoteDataSource>(
    () => ProductDetailRemoteDataSourceImpl(
      dio: serviceLocator<Dio>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<ProductDetailRepository>(
    () => ProductDetailRemoteRepository(
      remoteDataSource: serviceLocator<ProductDetailRemoteDataSource>(),
    ),
  );

  // Use Case
  serviceLocator.registerFactory<GetProductByIdUseCase>(
    () => GetProductByIdUseCase(
      repository: serviceLocator<ProductDetailRepository>(),
    ),
  );

  // ViewModel
  serviceLocator.registerFactory<ProductDetailViewModel>(
    () => ProductDetailViewModel(
      getProductByIdUseCase: serviceLocator<GetProductByIdUseCase>(),
    ),
  );
}

// ===============for profile================================================
void _initProfileModule() {
  // ViewModel
  serviceLocator.registerFactory<ProfileViewModel>(
    () => ProfileViewModel(
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );
}
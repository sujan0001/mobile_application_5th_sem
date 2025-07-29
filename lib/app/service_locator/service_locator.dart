
// // ============================================NEW SERVICE LOCATOR================================

// import 'package:batch34_b/app/shared_pref/token_shared_pref.dart';
// import 'package:batch34_b/core/network/api_service.dart';
// import 'package:batch34_b/core/network/hive_service.dart';
// import 'package:batch34_b/features/auth/data/data_source/local_datasource/user_local_data_source.dart';
// import 'package:batch34_b/features/auth/data/data_source/remote_data_source/user_remote_data_source.dart';
// import 'package:batch34_b/features/auth/data/repository/local_repository/user_local_repository.dart';
// import 'package:batch34_b/features/auth/data/repository/remote_repository/user_remote_repository.dart';
// import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
// import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:batch34_b/features/auth/domain/use_case/user_register_usecase.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';

// import 'package:batch34_b/features/dashboard/data/data_source/remote_data_source/dashboard_remote_data_source.dart';
// import 'package:batch34_b/features/dashboard/data/repository/remote_repository/dashboard_remote_repository_impl.dart';
// import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
// import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
// import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
// import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/navigation/view_model/navigation_cubit.dart';
// import 'package:batch34_b/features/s_marketplace/data/data_source/remote_data_source/request_transfer_remote_datasource_impl.dart';

// import 'package:batch34_b/features/s_marketplace/data/data_source/remote_data_source/s_marketplace_remote_data_source.dart';
// import 'package:batch34_b/features/s_marketplace/data/data_source/request_transfer_datasource.dart';
// import 'package:batch34_b/features/s_marketplace/data/repository/remote_repository/request_transfer_repository_impl.dart';
// import 'package:batch34_b/features/s_marketplace/data/repository/remote_repository/s_marketplace_remote_repository.dart';
// import 'package:batch34_b/features/s_marketplace/domain/repository/request_transfer_repository.dart';
// import 'package:batch34_b/features/s_marketplace/domain/repository/s_marketplace_repository.dart';
// import 'package:batch34_b/features/s_marketplace/domain/usecase/get_sold_products_usecase.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
// import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:batch34_b/features/s_marketplace/domain/usecase/request_product_transfer_usecase.dart';

// // Create a global instance of GetIt
// final serviceLocator = GetIt.instance;

// // Main initialization function
// Future<void> initDependencies() async {
//   // Registering services that need to be available as soon as the app starts
//   await _initCoreServices();
  
//   // Registering feature-specific dependencies
//   _initAuthModule();
//   _initSplashModule();
//   //for dashboard service locator
//   _initDashboardModule();
//   //for s_marketplace service locator
//   _initSMarketplaceModule();
//   //for request transfer button
  
// }



// // Private helper to register all core services
// Future<void> _initCoreServices() async {
//   // Dio and ApiService for networking
//   serviceLocator.registerLazySingleton(() => Dio());
//   serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));

//   // HiveService for local database
//   serviceLocator.registerLazySingleton(() => HiveService());
  
//   // SharedPreferences and Token handler for local key-value storage
//   final sharedPreferences = await SharedPreferences.getInstance();
//   serviceLocator.registerLazySingleton(() => sharedPreferences);
//   serviceLocator.registerLazySingleton(
//     () => TokenSharedPrefs(sharedPreferences: serviceLocator<SharedPreferences>()),
//   );
//   // Add this line in _initCoreServices() after TokenSharedPrefs registration
//   serviceLocator.registerLazySingleton<NavigationCubit>(() => NavigationCubit());
// }

// // Private helper to register all dependencies for the Authentication feature
// void _initAuthModule() {
//   // Data sources
//   // A new instance will be created every time it's requested
//   serviceLocator.registerFactory<UserRemoteDataSource>(
//     () => UserRemoteDataSource(apiService: serviceLocator<ApiService>()),
//   );
//   serviceLocator.registerFactory<UserLocalDataSource>(
//     () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
//   );

//   // Repositories
//   // We register UserRemoteRepository as the implementation for IUserRepository.
//   // This means whenever we ask for an IUserRepository, GetIt will provide a UserRemoteRepository.
//   // This makes it easy to switch to UserLocalRepository for testing or offline mode.
//   serviceLocator.registerFactory<IUserRepository>(
//     () => UserRemoteRepository(
//       userRemoteDataSource: serviceLocator<UserRemoteDataSource>(),
//     ),
//   );
//   // We also register the local repository if we need to access it directly somewhere.
//    serviceLocator.registerFactory<UserLocalRepository>(
//     () => UserLocalRepository(
//       userLocalDataSource: serviceLocator<UserLocalDataSource>(),
//     ),
//   );

//   // Use cases
//   serviceLocator.registerFactory<UserRegisterUsecase>(
//     () => UserRegisterUsecase(userRepository: serviceLocator<IUserRepository>()),
//   );
//   serviceLocator.registerFactory<UserLoginUsecase>(
//     () => UserLoginUsecase(
//       userRepository: serviceLocator<IUserRepository>(),
//       tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
//     ),
//   );

//   // ViewModels (Blocs)
//   serviceLocator.registerFactory<RegisterViewModel>(
//     () => RegisterViewModel(serviceLocator<UserRegisterUsecase>()),
//   );
//   serviceLocator.registerFactory<LoginViewModel>(
//     () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
//   );
// }

// // Private helper to register dependencies for the Splash feature
// void _initSplashModule() {
//   // Since we opted for a simplified View/ViewModel approach,
//   // we only need to register the SplashViewModel.
//   serviceLocator.registerFactory<SplashViewModel>(
//     // It directly depends on TokenSharedPrefs to check the login status.
//     () => SplashViewModel(serviceLocator<TokenSharedPrefs>()),
//   );
// }

// //service locator for dashboard starts here:========================================

// void _initDashboardModule() {
//   // Data Source
//   serviceLocator.registerFactory<DashboardRemoteDataSource>(
//     () => DashboardRemoteDataSource(apiService: serviceLocator<ApiService>()),
//   );

//   // Repository
//   serviceLocator.registerFactory<IDashboardRepository>(
//     () => DashboardRemoteRepositoryImpl(
//       dashboardDataSource: serviceLocator<DashboardRemoteDataSource>(),
//     ),
//   );

//   // Usecases
//   serviceLocator.registerFactory<GetAllCollectionsUseCase>(
//     () => GetAllCollectionsUseCase(
//       serviceLocator<IDashboardRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory<GetAvailableProductsUseCase>(
//     () => GetAvailableProductsUseCase(
//       serviceLocator<IDashboardRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory<GetAllCreatorsUseCase>(
//     () => GetAllCreatorsUseCase(
//       serviceLocator<IDashboardRepository>(),
//     ),
//   );

//   // ViewModel (Bloc / Cubit)
//   serviceLocator.registerFactory<DashboardViewModel>(
//   () => DashboardViewModel(
//     getAllCollectionsUseCase: serviceLocator<GetAllCollectionsUseCase>(),
//     getAvailableProductsUseCase: serviceLocator<GetAvailableProductsUseCase>(),
//     getAllCreatorsUseCase: serviceLocator<GetAllCreatorsUseCase>(),
//   ),
// );
// }

// //service locator for s_marketplace starts here:===================================

// void _initSMarketplaceModule() {
//   // Data Source
//   serviceLocator.registerFactory<SMarketplaceRemoteDataSource>(
//     () => SMarketplaceRemoteDataSource(apiService: serviceLocator<ApiService>()),
//   );

//   // Repository
//   serviceLocator.registerFactory<ISMarketplaceRepository>(
//     () => SMarketplaceRemoteRepository(
//       sMarketplaceRemoteDataSource: serviceLocator<SMarketplaceRemoteDataSource>(),
//     ),
//   );

//   // Usecases
//   serviceLocator.registerFactory<GetSoldProductsUsecase>(
//     () => GetSoldProductsUsecase(
//       sMarketplaceRepository: serviceLocator<ISMarketplaceRepository>(),
//     ),
//   );

//   // ViewModel (Bloc)
//   serviceLocator.registerFactory<SMarketplaceViewModel>(
//     () => SMarketplaceViewModel(
//       serviceLocator<GetSoldProductsUsecase>(),
//     ),
//   );
// }
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
import 'package:batch34_b/features/permission_creator/data/data_source/remote_datasource/transfer_request_remote_datasource_impl.dart';
import 'package:batch34_b/features/permission_creator/data/data_source/transfer_request_remote_datasource.dart';
import 'package:batch34_b/features/permission_creator/data/repository/remote_repository/transfer_request_repository_impl.dart';
import 'package:batch34_b/features/permission_creator/domain/repository/transfer_request_repository.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/et_incoming_transfer_requests.dart';
import 'package:batch34_b/features/permission_creator/domain/use_case/respond_to_transfer_request.dart';
import 'package:batch34_b/features/permission_creator/presentation/view_model/permission_creator_view_model.dart';
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
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
// import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final serviceLocator = GetIt.instance;

// Future<void> initDependencies() async {
//   await _initHiveService();
//   await _initSharedPrefs();
//   await _initApiService();
//   await _initAuthModule();
//   // Assuming you have a splash screen feature
//   // await _initSplashModule(); 
// }

// Future<void> _initApiService() async {
//   serviceLocator.registerLazySingleton(() => ApiService(Dio()));
// }

// Future<void> _initHiveService() async {
//   serviceLocator.registerLazySingleton(() => HiveService());
// }

// Future<void> _initSharedPrefs() async {
//   final sharedPrefs = await SharedPreferences.getInstance();
//   serviceLocator.registerLazySingleton(() => sharedPrefs);
//   serviceLocator.registerLazySingleton(
//     () => TokenSharedPrefs(
//       sharedPreferences: serviceLocator<SharedPreferences>(),
//     ),
//   );
// }

// Future<void> _initAuthModule() async {
//   // Data Sources
//   serviceLocator.registerFactory<UserLocalDataSource>(
//     () => UserLocalDataSource(hiveService: serviceLocator<HiveService>()),
//   );

//   serviceLocator.registerFactory<UserRemoteDataSource>(
//     () => UserRemoteDataSource(apiService: serviceLocator<ApiService>()),
//   );

//   // Repositories
//   // Registering the remote repository as the primary implementation of IUserRepository
//   serviceLocator.registerFactory<IUserRepository>(
//     () => UserRemoteRepository(
//       userRemoteDataSource: serviceLocator<UserRemoteDataSource>(),
//     ),
//   );
//    serviceLocator.registerFactory<UserLocalRepository>(
//     () => UserLocalRepository(
//       userLocalDataSource: serviceLocator<UserLocalDataSource>(),
//     ),
//   );

//   // Use Cases
//   serviceLocator.registerFactory<UserLoginUsecase>(
//     () => UserLoginUsecase(
//       userRepository: serviceLocator<IUserRepository>(),
//       tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
//     ),
//   );

//   serviceLocator.registerFactory<UserRegisterUsecase>(
//     () => UserRegisterUsecase(
//       userRepository: serviceLocator<IUserRepository>(),
//     ),
//   );

//   // View Models
//   serviceLocator.registerFactory<RegisterViewModel>(
//     () => RegisterViewModel(
//       serviceLocator<UserRegisterUsecase>(),
//     ),
//   );
  
//   serviceLocator.registerFactory<LoginViewModel>(
//     () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
//   );
// }

// Future<void> _initSplashModule() async {
//     serviceLocator.registerFactory(
//     () => SplashViewModel(serviceLocator<TokenSharedPrefs>()),
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
import 'package:batch34_b/features/dashboard/data/data_source/dashboard_data_source.dart';
import 'package:batch34_b/features/dashboard/data/data_source/remote_data_source/dashboard_remote_data_source.dart';
import 'package:batch34_b/features/dashboard/data/repository/remote_repository/dashboard_remote_repository_impl.dart';
import 'package:batch34_b/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
  _initDashboardModule(); // Add this line

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



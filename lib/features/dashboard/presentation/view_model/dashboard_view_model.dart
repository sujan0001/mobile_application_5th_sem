// // dashboard_view_model.dart
// import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
// import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
// import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dashboard_event.dart';
// import 'dashboard_state.dart';

// class DashboardViewModel extends Bloc<DashboardEvent, DashboardState> {
//   final GetAllCollectionsUseCase getAllCollectionsUseCase;
//   final GetAvailableProductsUseCase getAvailableProductsUseCase;
//   final GetAllCreatorsUseCase getAllCreatorsUseCase;

//   DashboardViewModel({
//     required this.getAllCollectionsUseCase,
//     required this.getAvailableProductsUseCase,
//     required this.getAllCreatorsUseCase,
//   }) : super(const DashboardState.initial()) {
//     on<LoadDashboardDataEvent>(_onLoadDashboardData);
//   }

//   Future<void> _onLoadDashboardData(
//     LoadDashboardDataEvent event,
//     Emitter<DashboardState> emit,
//   ) async {
//     print('🔥 LoadDashboardDataEvent received');
//     print('🔥 Current state: isLoading=${state.isLoading}, collections=${state.collections.length}, products=${state.products.length}, creators=${state.creators.length}');
    
//     emit(state.copyWith(isLoading: true));
//     print('🔥 Loading state emitted');

//     try {
//       print('🔥 Calling getAllCollectionsUseCase...');
//       final collectionResult = await getAllCollectionsUseCase();
//       print('🔥 Collections result: ${collectionResult.toString()}');
      
//       print('🔥 Calling getAvailableProductsUseCase...');
//       final productResult = await getAvailableProductsUseCase();
//       print('🔥 Products result: ${productResult.toString()}');
      
//       print('🔥 Calling getAllCreatorsUseCase...');
//       final creatorResult = await getAllCreatorsUseCase();
//       print('🔥 Creators result: ${creatorResult.toString()}');

//       final collections = collectionResult.getOrElse(() => []);
//       final products = productResult.getOrElse(() => []);
//       final creators = creatorResult.getOrElse(() => []);

//       print('🔥 Final data: collections=${collections.length}, products=${products.length}, creators=${creators.length}');

//       emit(state.copyWith(
//         isLoading: false,
//         collections: collections,
//         products: products,
//         creators: creators,
//       ));
      
//       print('🔥 Final state emitted');
//     } catch (e) {
//       print('🔥 Error in _onLoadDashboardData: $e');
//       emit(state.copyWith(isLoading: false));
//     }
//   }
// }
// dashboard_view_model.dart
// dashboard_view_model.dart
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_collections_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_all_creators_usecase.dart';
import 'package:batch34_b/features/dashboard/domain/use_case/get_available_products_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view/login_page_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void logout(BuildContext context) async {
    print("Logout triggered by shake");

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // STEP 1: Backup biometric data before clearing (using correct keys)
      final storedUsername = prefs.getString('stored_username');
      final storedPassword = prefs.getString('stored_password');
      final biometricEnabled = prefs.getBool('biometric_enabled') ?? false;
      
      print('Backing up biometric data before logout:');
      print('Stored username: $storedUsername');
      print('Stored password exists: ${storedPassword != null}');
      print('Biometric enabled: $biometricEnabled');
      
      // STEP 2: Clear all session-related preferences but keep biometric data
      // Remove session data
      await prefs.remove('token');
      await prefs.remove('userId');
      await prefs.remove('role');
      await prefs.remove('username');
      
      // Remove any other session-specific data you might have
      // But preserve biometric credentials if they exist
      
      print('Session data cleared, biometric data preserved');
      
      // STEP 3: Verify biometric data is still there (if it was there before)
      if (biometricEnabled && storedUsername != null && storedPassword != null) {
        print('Biometric data verification after logout:');
        print('Username still stored: ${prefs.getString('stored_username')}');
        print('Password still exists: ${prefs.getString('stored_password') != null}');
        print('Biometric still enabled: ${prefs.getBool('biometric_enabled')}');
      } else {
        print('No biometric data was configured');
      }

      // Navigate to login screen and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => serviceLocator<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        ),
        (route) => false,
      );
      
      print("Logout completed successfully with biometric data preserved");
      
    } catch (e) {
      print('Error during logout: $e');
      
      // Even if there's an error, still navigate to login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => serviceLocator<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        ),
        (route) => false,
      );
    }
  }

  // Alternative method if you want to completely clear everything including biometrics
  void logoutAndClearBiometrics(BuildContext context) async {
    print("Logout with biometric clearing triggered");

    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Clear ALL preferences including biometric data
      await prefs.clear();
      print('All preferences cleared including biometric data');

      // Navigate to login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => serviceLocator<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        ),
        (route) => false,
      );
      
      print("Complete logout finished");
      
    } catch (e) {
      print('Error during complete logout: $e');
      
      // Still navigate even if there's an error
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider<LoginViewModel>(
            create: (_) => serviceLocator<LoginViewModel>(),
            child: const LoginScreen(),
          ),
        ),
        (route) => false,
      );
    }
  }
}
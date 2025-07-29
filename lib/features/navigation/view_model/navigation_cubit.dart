
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0); // Start with first tab (Dashboard)

  void changeTab(int index) {
    emit(index);
  }

  void goToDashboard() => emit(0);
  void goToMarketplace() => emit(1);
  void goToPermissions() => emit(2);
}
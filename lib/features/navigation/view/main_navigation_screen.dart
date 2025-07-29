
// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/features/dashboard/presentation/view/dashboard_page_view.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';

// import 'package:batch34_b/features/navigation/view_model/navigation_cubit.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view/s_marketplace_view.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class MainNavigationScreen extends StatelessWidget {
//   const MainNavigationScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Create screens with their respective BlocProviders
//     final List<Widget> screens = [
//       // Dashboard Screen with its ViewModel
//       BlocProvider.value(
//         value: serviceLocator<DashboardViewModel>(),
//         child: const DashboardPageView(),
//       ),
//       // Marketplace Screen with its ViewModel
//       BlocProvider.value(
//         value: serviceLocator<SMarketplaceViewModel>(),
//         child: const SMarketplaceView(),
//       ),
//     ];

//     return BlocProvider(
//       create: (_) => NavigationCubit(),
//       child: BlocBuilder<NavigationCubit, int>(
//         builder: (context, currentIndex) {
//           return Scaffold(
//             body: IndexedStack(
//               index: currentIndex,
//               children: screens,
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               currentIndex: currentIndex,
//               onTap: (index) {
//                 context.read<NavigationCubit>().changeTab(index);
//               },
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: Theme.of(context).primaryColor,
//               unselectedItemColor: Colors.grey,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.dashboard),
//                   label: 'Dashboard',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.store),
//                   label: 'Marketplace',
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/features/dashboard/presentation/view/dashboard_page_view.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/navigation/view_model/navigation_cubit.dart';
import 'package:batch34_b/features/owned_products/presentation/view/my_owned_products_view.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_bloc.dart';
import 'package:batch34_b/features/permission_creator/presentation/view/permission_creator_view.dart';
import 'package:batch34_b/features/permission_creator/presentation/view_model/permission_creator_view_model.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view/s_marketplace_view.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create screens with their respective providers
    final List<Widget> screens = [
      // Dashboard Screen with its ViewModel
      BlocProvider.value(
        value: serviceLocator<DashboardViewModel>(),
        child: const DashboardPageView(),
      ),
      // Marketplace Screen with its ViewModel
      BlocProvider.value(
        value: serviceLocator<SMarketplaceViewModel>(),
        child: const SMarketplaceView(),
      ),
      // My owned products screen with its view model
      BlocProvider(
        create: (_) => serviceLocator<OwnedProductsBloc>(),
        child: const MyOwnedProductsView(),
      ),
      // Permission Creator Screen with its ViewModel
      ChangeNotifierProvider.value(
        value: serviceLocator<PermissionCreatorViewModel>(),
        child: const PermissionCreatorView(),
      ),
    ];

    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: IndexedStack(
              index: currentIndex,
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<NavigationCubit>().changeTab(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.store),
                  label: 'Marketplace',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2),
                  label: 'Owned Products',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.admin_panel_settings),
                  label: 'Permissions',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

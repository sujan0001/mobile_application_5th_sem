// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_collection_carosuel.dart';
// import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_creators_section.dart';
// import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_products_grid.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../view_model/dashboard_state.dart';

// class DashboardPageView extends StatefulWidget {
//   const DashboardPageView({super.key});

//   @override
//   State<DashboardPageView> createState() => _DashboardPageViewState();
// }

// class _DashboardPageViewState extends State<DashboardPageView> {
//   @override
//   void initState() {
//     super.initState();
//     _loadDashboardData();
//   }

//   void _loadDashboardData() {
//     Future.delayed(const Duration(milliseconds: 100), () {
//       if (mounted) {
//         context.read<DashboardViewModel>().add(
//           LoadDashboardDataEvent(context: context),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange[100],
//       body: BlocBuilder<DashboardViewModel, DashboardState>(
//         builder: (context, state) {
//           return SafeArea(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 _loadDashboardData();
//               },
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Status Bar
//                     // _buildStatusBar(),
                    
//                     // Header
//                     _buildHeader(),

//                     // Collections Carousel
//                     const MobileCollectionCarousel(),
//                     const SizedBox(height: 16),

//                     // Verified Creators Section
//                     const MobileCreatorsSection(),
//                     const SizedBox(height: 16),

//                     // Newly Listed Products
//                     const MobileProductsGrid(),
//                     const SizedBox(height: 80), // Space for bottom navigation
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//       // bottomNavigationBar: _buildBottomNavigation(),
//     );
//   }

//   Widget _buildStatusBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "09:47",
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: Colors.black,
//             ),
//           ),
//           Row(
//             children: [
//               // Signal bars
//               Row(
//                 children: List.generate(4, (index) => Container(
//                   width: 2,
//                   height: 8,
//                   margin: const EdgeInsets.only(right: 1),
//                   decoration: BoxDecoration(
//                     color: index < 3 ? Colors.black : Colors.grey[300],
//                     borderRadius: BorderRadius.circular(1),
//                   ),
//                 )),
//               ),
//               const SizedBox(width: 4),
//               // Battery
//               Container(
//                 width: 20,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black, width: 1),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: 16,
//                       height: 8,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(1),
//                       ),
//                     ),
//                     Positioned(
//                       right: -1,
//                       top: 3,
//                       child: Container(
//                         width: 2,
//                         height: 4,
//                         decoration: const BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(1),
//                             bottomRight: Radius.circular(1),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: Colors.grey[300],
//             child: const Icon(Icons.person, color: Colors.grey),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "WELCOME",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   "let's explore stamped goods",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               // Add search functionality
//             },
//             icon: const Icon(Icons.search, color: Colors.black),
//             style: IconButton.styleFrom(
//               backgroundColor: Colors.grey[100],
//               shape: const CircleBorder(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavigation() {
//     return Container(
//       height: 80,
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(color: Colors.grey, width: 0.2),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(Icons.home, true),
//           _buildNavItem(Icons.layers, false),
//           _buildNavItem(Icons.favorite_border, false),
//           _buildNavItem(Icons.person_outline, false),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, bool isActive) {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(
//         color: isActive ? Colors.green[600] : Colors.transparent,
//         shape: BoxShape.circle,
//       ),
//       child: Icon(
//         icon,
//         color: isActive ? Colors.white : Colors.grey,
//         size: 20,
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_collection_carosuel.dart';
import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_creators_section.dart';
import 'package:batch34_b/features/dashboard/presentation/widgets/mobile_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../view_model/dashboard_state.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({super.key});

  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  late StreamSubscription _accelerometerSubscription;
  double _shakeThreshold = 15.0;
  DateTime? _lastShakeTime;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
    _startListeningToShake();
  }

  @override
  void dispose() {
    _accelerometerSubscription.cancel();
    super.dispose();
  }

  void _startListeningToShake() {
    _accelerometerSubscription = accelerometerEventStream().listen((event) {
      double acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      if (acceleration > _shakeThreshold) {
        final now = DateTime.now();
        if (_lastShakeTime == null ||
            now.difference(_lastShakeTime!) > const Duration(seconds: 2)) {
          _lastShakeTime = now;
          _onShakeDetected();
        }
      }
    });
  }

  void _onShakeDetected() {
    final dashboardViewModel = context.read<DashboardViewModel>();
    dashboardViewModel.logout(context);
  }

  void _loadDashboardData() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        context.read<DashboardViewModel>().add(
          LoadDashboardDataEvent(context: context),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                _loadDashboardData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status Bar
                    // _buildStatusBar(),
                    
                    // Header
                    _buildHeader(),

                    // Collections Carousel
                    const MobileCollectionCarousel(),
                    const SizedBox(height: 16),

                    // Verified Creators Section
                    const MobileCreatorsSection(),
                    const SizedBox(height: 16),

                    // Newly Listed Products
                    const MobileProductsGrid(),
                    const SizedBox(height: 80), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildStatusBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "09:47",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              // Signal bars
              Row(
                children: List.generate(4, (index) => Container(
                  width: 2,
                  height: 8,
                  margin: const EdgeInsets.only(right: 1),
                  decoration: BoxDecoration(
                    color: index < 3 ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(1),
                  ),
                )),
              ),
              const SizedBox(width: 4),
              // Battery
              Container(
                width: 20,
                height: 10,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 16,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    Positioned(
                      right: -1,
                      top: 3,
                      child: Container(
                        width: 2,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(1),
                            bottomRight: Radius.circular(1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "WELCOME",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "let's explore stamped goods",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Add search functionality
            },
            icon: const Icon(Icons.search, color: Colors.black),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey[100],
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, true),
          _buildNavItem(Icons.layers, false),
          _buildNavItem(Icons.favorite_border, false),
          _buildNavItem(Icons.person_outline, false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isActive ? Colors.green[600] : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey,
        size: 20,
      ),
    );
  }
}
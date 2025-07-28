import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/widgets/collection_widget.dart';

import 'package:batch34_b/features/dashboard/presentation/widgets/products_widget.dart';
import 'package:batch34_b/features/dashboard/presentation/widgets/creators_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/dashboard_state.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({super.key});

  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  @override
  void initState() {
    super.initState();
    _loadDashboardData();
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
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
        ],
      ),
      body: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              _loadDashboardData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Debug info (you can remove this in production)
                  if (state.isLoading || 
                      state.collections.isNotEmpty || 
                      state.products.isNotEmpty || 
                      state.creators.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: state.isLoading ? Colors.orange[100] : Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: state.isLoading ? Colors.orange : Colors.green,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Debug Info:", 
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Collections: ${state.collections.length}"),
                          Text("Products: ${state.products.length}"),
                          Text("Creators: ${state.creators.length}"),
                          Text("Loading: ${state.isLoading}"),
                        ],
                      ),
                    ),

                  // Collections Widget
                  const CollectionsWidget(),
                  const SizedBox(height: 16),

                  // Products Widget
                  const ProductsWidget(),
                  const SizedBox(height: 16),

                  // Creators Widget
                  const CreatorsWidget(),
                  const SizedBox(height: 16),

                  // Show message if all data is empty and not loading
                  if (!state.isLoading && 
                      state.collections.isEmpty && 
                      state.products.isEmpty && 
                      state.creators.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.dashboard_outlined, 
                              size: 60, 
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "No Data Available",
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Pull down to refresh or tap the refresh button",
                              style: TextStyle(
                                fontSize: 14, 
                                color: Colors.grey[600],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
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
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loadDashboardData,
//           ),
//         ],
//       ),
//       body: BlocConsumer<DashboardViewModel, DashboardState>(
//         listener: (context, state) {
//           // Handle any state changes that need user feedback
//           if (state.isLoading) {
//             print('🔄 Dashboard loading...');
//           }
//         },
//         builder: (context, state) {
//           return RefreshIndicator(
//             onRefresh: () async {
//               _loadDashboardData();
//             },
//             child: SingleChildScrollView(
//               physics: const AlwaysScrollableScrollPhysics(),
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Debug info (remove in production)
//                   _buildDebugCard(state),
                  
//                   // Stats Overview Cards
//                   _buildStatsOverview(state),
//                   const SizedBox(height: 24),

//                   // Collections Section
//                   _buildCollectionsSection(state),
//                   const SizedBox(height: 20),

//                   // Products Section  
//                   _buildProductsSection(state),
//                   const SizedBox(height: 20),

//                   // Creators Section
//                   _buildCreatorsSection(state),

//                   // Empty state
//                   if (_isAllEmpty(state) && !state.isLoading)
//                     _buildEmptyState(),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDebugCard(DashboardState state) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         color: state.isLoading ? Colors.orange[50] : Colors.green[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: state.isLoading ? Colors.orange[200]! : Colors.green[200]!,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 state.isLoading ? Icons.hourglass_empty : Icons.check_circle,
//                 color: state.isLoading ? Colors.orange[600] : Colors.green[600],
//                 size: 20,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 "Debug Info",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: state.isLoading ? Colors.orange[800] : Colors.green[800],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text("Collections: ${state.collections.length}"),
//           Text("Products: ${state.products.length}"),
//           Text("Creators: ${state.creators.length}"),
//           Text("Loading: ${state.isLoading}"),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatsOverview(DashboardState state) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildStatCard(
//             "Collections",
//             state.collections.length.toString(),
//             Icons.collections,
//             Colors.blue,
//             state.isLoading,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildStatCard(
//             "Products",
//             state.products.length.toString(),
//             Icons.inventory,
//             Colors.orange,
//             state.isLoading,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: _buildStatCard(
//             "Creators",
//             state.creators.length.toString(),
//             Icons.people,
//             Colors.purple,
//             state.isLoading,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(String title, String count, IconData icon, Color color, bool isLoading) {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Icon(icon, color: color, size: 32),
//             const SizedBox(height: 12),
//             isLoading
//                 ? SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: color,
//                     ),
//                   )
//                 : Text(
//                     count,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: color,
//                     ),
//                   ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCollectionsSection(DashboardState state) {
//     if (state.collections.isEmpty && !state.isLoading) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Collections", state.collections.length),
//         const SizedBox(height: 12),
//         if (state.isLoading && state.collections.isEmpty)
//           _buildLoadingCard("collections")
//         else
//           ...state.collections.map((collection) => _buildCollectionCard(collection)),
//       ],
//     );
//   }

//   Widget _buildProductsSection(DashboardState state) {
//     if (state.products.isEmpty && !state.isLoading) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Products", state.products.length),
//         const SizedBox(height: 12),
//         if (state.isLoading && state.products.isEmpty)
//           _buildLoadingCard("products")
//         else
//           ...state.products.map((product) => _buildProductCard(product)),
//       ],
//     );
//   }

//   Widget _buildCreatorsSection(DashboardState state) {
//     if (state.creators.isEmpty && !state.isLoading) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Creators", state.creators.length),
//         const SizedBox(height: 12),
//         if (state.isLoading && state.creators.isEmpty)
//           _buildLoadingCard("creators")
//         else
//           ...state.creators.map((creator) => _buildCreatorCard(creator)),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title, int count) {
//     return Row(
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             count.toString(),
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoadingCard(String type) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             const CircularProgressIndicator(),
//             const SizedBox(width: 16),
//             Text("Loading $type..."),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCollectionCard(collection) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Collection image placeholder
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 Icons.collections,
//                 color: Colors.blue[600],
//                 size: 30,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     collection.title ?? 'Untitled Collection',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   if (collection.description != null)
//                     Text(
//                       collection.description!,
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 14,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       if (collection.creator != null)
//                         Chip(
//                           label: Text(
//                             'by ${collection.creator!.firstName}',
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                           backgroundColor: Colors.blue[50],
//                           labelPadding: const EdgeInsets.symmetric(horizontal: 4),
//                         ),
//                       const Spacer(),
//                       if (collection.certified == true)
//                         const Icon(
//                           Icons.verified,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard(product) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Product image placeholder
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.orange[100],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(
//                 Icons.inventory,
//                 color: Colors.orange[600],
//                 size: 30,
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name ?? 'Unnamed Product',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   if (product.description != null)
//                     Text(
//                       product.description!,
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 14,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green[100],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           '\$${(product.originalPrice ?? 0.0).toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green[800],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       if (product.onSale == true)
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 6,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.orange,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Text(
//                             'ON SALE',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       const Spacer(),
//                       if (product.certified == true)
//                         const Icon(
//                           Icons.verified,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCreatorCard(creator) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 8),
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Row(
//           children: [
//             // Creator avatar
//             CircleAvatar(
//               radius: 30,
//               backgroundColor: Colors.purple[200],
//               child: Text(
//                 (creator.firstName?.isNotEmpty ?? false) 
//                     ? creator.firstName![0].toUpperCase() 
//                     : 'U',
//                 style: TextStyle(
//                   color: Colors.purple[800],
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     creator.fullName ?? '${creator.firstName ?? 'Unknown'} ${creator.lastName ?? ''}',
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     creator.email ?? 'No email',
//                     style: TextStyle(
//                       color: Colors.grey[600],
//                       fontSize: 14,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 4,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.purple[100],
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       (creator.role ?? 'creator').toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.purple[800],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           children: [
//             Icon(
//               Icons.dashboard_outlined,
//               size: 80,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               "No Data Available",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Pull down to refresh or tap the refresh button to load data",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool _isAllEmpty(DashboardState state) {
//     return state.collections.isEmpty && 
//            state.products.isEmpty && 
//            state.creators.isEmpty;
//   }
// }
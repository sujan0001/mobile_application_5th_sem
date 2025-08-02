// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
//  // Update path as needed
// import 'package:batch34_b/core/utils/backend_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SMarketplaceView extends StatefulWidget {
//   const SMarketplaceView({super.key});

//   @override
//   State<SMarketplaceView> createState() => _SMarketplaceViewState();
// }

// class _SMarketplaceViewState extends State<SMarketplaceView> {
//   @override
//   void initState() {
//     super.initState();
//     // Load sold products when the view is initialized
//     context.read<SMarketplaceViewModel>().add(LoadSoldProductsEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Secondary Marketplace',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.grey.shade900,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // TODO: Implement search functionality
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Search functionality coming soon!')),
//               );
//             },
//           ),
//         ],
//       ),
//       body: BlocConsumer<SMarketplaceViewModel, SMarketplaceState>(
//         listener: (context, state) {
//           if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage!),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state.isLoading && state.soldProducts.isEmpty) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (state.soldProducts.isEmpty && !state.isLoading) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.inventory_2_outlined,
//                     size: 80,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'No products available',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Check back later for new items',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<SMarketplaceViewModel>().add(RefreshSoldProductsEvent());
//             },
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: state.soldProducts.length,
//               itemBuilder: (context, index) {
//                 final product = state.soldProducts[index];
//                 return _buildProductCard(context, product);
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(BuildContext context, ProductEntity product) {
//     return BlocProvider(
//       create: (context) => serviceLocator<RequestTransferCubit>(),
//       child: Card(
//         margin: const EdgeInsets.only(bottom: 16),
//         elevation: 4,
//         color: Colors.grey.shade800,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: InkWell(
//           onTap: () {
//             context.read<SMarketplaceViewModel>().add(
//                   NavigateToProductDetailsEvent(
//                     context: context,
//                     productId: product.id,
//                   ),
//                 );
//           },
//           borderRadius: BorderRadius.circular(12),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Image
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Container(
//                     width: 80,
//                     height: 80,
//                     color: Colors.grey.shade700,
//                     child: product.image.isNotEmpty
//                         ? Builder(
//                             builder: (context) {
//                               // Debug prints
//                               String imageUrl = getBackendImageUrl(product.image);
//                               print('Product image path: ${product.image}');
//                               print('Final URL: $imageUrl');
                              
//                               return Image.network(
//                                 imageUrl, // Use utility function instead of hardcoded URL
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   print('Image loading error: $error');
//                                   return const Icon(
//                                     Icons.image_not_supported,
//                                     color: Colors.grey,
//                                     size: 40,
//                                   );
//                                 },
//                               );
//                             },
//                           )
//                         : const Icon(
//                             Icons.image,
//                             color: Colors.grey,
//                             size: 40,
//                           ),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
                
//                 // Product Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       if (product.description != null)
//                         Text(
//                           product.description!,
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       const SizedBox(height: 8),
                      
//                       // Price Row
//                       Row(
//                         children: [
//                           Text(
//                             'Original: \$${product.originalPrice.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               color: Colors.white54,
//                               fontSize: 12,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           if (product.resalePrice != null)
//                             Text(
//                               '\$${product.resalePrice!.toStringAsFixed(2)}',
//                               style: TextStyle(
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
                      
//                       // Status and Owner
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color: product.onSale ? Colors.green : Colors.orange,
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                             child: Text(
//                               product.onSale ? 'On Sale' : 'Sold',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const Spacer(),
//                           if (product.certified)
//                             const Icon(
//                               Icons.verified,
//                               color: Colors.blue,
//                               size: 20,
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Owner: ${product.owner?.firstName ?? 'Unknown'} ${product.owner?.lastName ?? ''}',
//                         style: const TextStyle(
//                           color: Colors.white60,
//                           fontSize: 12,
//                         ),
//                       ),
                      
//                       // Request Transfer Button - NEW
//                       const SizedBox(height: 12),
//                       _buildRequestTransferButton(context, product),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRequestTransferButton(BuildContext context, ProductEntity product) {
//     return BlocConsumer<RequestTransferCubit, RequestTransferState>(
//       listener: (context, state) {
//         // Handle success and error states
//         if (state.runtimeType.toString().contains('Success')) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Transfer request sent successfully!'),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         } else if (state.runtimeType.toString().contains('Failure') || 
//                    state.runtimeType.toString().contains('Error')) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Failed to send transfer request. Please try again.'),
//               backgroundColor: Colors.red,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         final isLoading = state.runtimeType.toString().contains('Loading');
        
//         return SizedBox(
//           width: double.infinity,
//           height: 36,
//           child: ElevatedButton.icon(
//             onPressed: isLoading ? null : () => _requestTransfer(context, product),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 2,
//             ),
//             icon: isLoading
//                 ? const SizedBox(
//                     height: 16,
//                     width: 16,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : const Icon(Icons.swap_horiz, size: 18),
//             label: Text(
//               isLoading ? 'Requesting...' : 'Request Transfer',
//               style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _requestTransfer(BuildContext context, ProductEntity product) {
//     final cubit = context.read<RequestTransferCubit>();
    
//     // Validate product ID
//     if (product.id.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid product ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Show confirmation dialog (optional)
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.grey.shade800,
//           title: const Text(
//             'Request Transfer',
//             style: TextStyle(color: Colors.white),
//           ),
//           content: Text(
//             'Do you want to request transfer for "${product.name}"?',
//             style: const TextStyle(color: Colors.white70),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Trigger the request transfer
//                 cubit.requestProductTransfer(product.id);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blue,
//               ),
//               child: const Text(
//                 'Confirm',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
// import 'package:batch34_b/features/product_details/presentation/view/product_detail_view.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SMarketplaceView extends StatefulWidget {
//   const SMarketplaceView({super.key});

//   @override
//   State<SMarketplaceView> createState() => _SMarketplaceViewState();
// }

// class _SMarketplaceViewState extends State<SMarketplaceView> {
//   @override
//   void initState() {
//     super.initState();
//     // Load sold products when the view is initialized
//     context.read<SMarketplaceViewModel>().add(LoadSoldProductsEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Secondary Marketplace',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.grey.shade900,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // TODO: Implement search functionality
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Search functionality coming soon!')),
//               );
//             },
//           ),
//         ],
//       ),
//       backgroundColor: Colors.grey.shade100,
//       body: BlocConsumer<SMarketplaceViewModel, SMarketplaceState>(
//         listener: (context, state) {
//           if (state.errorMessage != null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errorMessage!),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state.isLoading && state.soldProducts.isEmpty) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           if (state.soldProducts.isEmpty && !state.isLoading) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.inventory_2_outlined,
//                     size: 80,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'No products available',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Check back later for new items',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<SMarketplaceViewModel>().add(RefreshSoldProductsEvent());
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2, // 2 columns
//                   childAspectRatio: 0.65, // Adjust ratio for better card proportions
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemCount: state.soldProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = state.soldProducts[index];
//                   return _buildProductCard(context, product);
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(BuildContext context, ProductEntity product) {
//     return BlocProvider(
//       create: (context) => serviceLocator<RequestTransferCubit>(),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Image
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                   child: Container(
//                     height: 140,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[300],
//                     ),
//                     child: product.image.isNotEmpty
//                         ? Builder(
//                             builder: (context) {
//                               String imageUrl = getBackendImageUrl(product.image);
//                               return Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Center(
//                                     child: Icon(
//                                       Icons.image_not_supported,
//                                       size: 50,
//                                       color: Colors.grey,
//                                     ),
//                                   );
//                                 },
//                                 loadingBuilder: (context, child, loadingProgress) {
//                                   if (loadingProgress == null) return child;
//                                   return const Center(
//                                     child: CircularProgressIndicator(),
//                                   );
//                                 },
//                               );
//                             },
//                           )
//                         : const Center(
//                             child: Icon(
//                               Icons.image_not_supported,
//                               size: 50,
//                               color: Colors.grey,
//                             ),
//                           ),
//                   ),
//                 ),
                
//                 // Product Details
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Product Name
//                         Text(
//                           product.name,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
                        
//                         const SizedBox(height: 4),
                        
//                         // Description (if available)
//                         if (product.description != null && product.description!.isNotEmpty) ...[
//                           Text(
//                             product.description!,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[600],
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 6),
//                         ],
                        
//                         // Status Badge and Certified Icon
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 6,
//                                 vertical: 2,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: product.onSale ? Colors.green[100] : Colors.orange[100],
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                               child: Text(
//                                 product.onSale ? 'On Sale' : 'Sold',
//                                 style: TextStyle(
//                                   color: product.onSale ? Colors.green[800] : Colors.orange[800],
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const Spacer(),
//                             if (product.certified)
//                               Icon(
//                                 Icons.verified,
//                                 color: Colors.blue[600],
//                                 size: 16,
//                               ),
//                           ],
//                         ),
                        
//                         const SizedBox(height: 6),
                        
//                         // Original Price (crossed out)
//                         Text(
//                           'Original: \$${product.originalPrice.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             color: Colors.grey[500],
//                             fontSize: 11,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
                        
//                         // Current/Resale Price
//                         if (product.resalePrice != null)
//                           Text(
//                             '\$${product.resalePrice!.toStringAsFixed(2)}',
//                             style: const TextStyle(
//                               color: Colors.green,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
                        
//                         const SizedBox(height: 4),
                        
//                         // Owner Info
//                         Text(
//                           'Owner: ${product.owner?.firstName ?? 'Unknown'} ${product.owner?.lastName ?? ''}',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 10,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
                        
//                         const Spacer(),
                        
//                         // Request Transfer Button (only this button now)
//                         _buildRequestTransferButton(context, product),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
            
//             // Arrow button for navigation to details (positioned like in mobile_products_grid)
//             Positioned(
//               top: 8,
//               right: 8,
//               child: GestureDetector(
//                 onTap: () => _navigateToProductDetails(context, product.id),
//                 child: Container(
//                   width: 24,
//                   height: 24,
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.arrow_forward,
//                     size: 12,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRequestTransferButton(BuildContext context, ProductEntity product) {
//     return BlocConsumer<RequestTransferCubit, RequestTransferState>(
//       listener: (context, state) {
//         // Handle success and error states
//         if (state.runtimeType.toString().contains('Success')) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Transfer request sent successfully!'),
//               backgroundColor: Colors.green,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         } else if (state.runtimeType.toString().contains('Failure') || 
//                    state.runtimeType.toString().contains('Error')) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to send transfer request. Please try again.'),
//               backgroundColor: Colors.red,
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         final isLoading = state.runtimeType.toString().contains('Loading');
        
//         return SizedBox(
//           width: double.infinity,
//           height: 32,
//           child: ElevatedButton.icon(
//             onPressed: isLoading ? null : () => _requestTransfer(context, product),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.green[600],
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               elevation: 2,
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//             ),
//             icon: isLoading
//                 ? const SizedBox(
//                     height: 12,
//                     width: 12,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 2,
//                     ),
//                   )
//                 : const Icon(Icons.swap_horiz, size: 14),
//             label: Text(
//               isLoading ? 'Requesting...' : 'Request Transfer',
//               style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   void _navigateToProductDetails(BuildContext context, String productId) {
//     // Validate product ID
//     if (productId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid product ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Navigate to product details page using MaterialPageRoute
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ProductDetailView(
//           productId: productId,
//           isOwned: false, // Set to false since this is from marketplace (not owned)
//         ),
//       ),
//     );
//   }

//   void _requestTransfer(BuildContext context, ProductEntity product) {
//     final cubit = context.read<RequestTransferCubit>();
    
//     // Validate product ID
//     if (product.id.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid product ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Show confirmation dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Request Transfer'),
//           content: Text(
//             'Do you want to request transfer for "${product.name}"?\n\nPrice: \$${product.resalePrice?.toStringAsFixed(2) ?? 'N/A'}',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.grey[600]),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 // Trigger the request transfer
//                 cubit.requestProductTransfer(product.id);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green[600],
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
import 'package:batch34_b/features/product_details/presentation/view/product_detail_view.dart';
import 'package:batch34_b/core/utils/backend_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SMarketplaceView extends StatefulWidget {
  const SMarketplaceView({super.key});

  @override
  State<SMarketplaceView> createState() => _SMarketplaceViewState();
}

class _SMarketplaceViewState extends State<SMarketplaceView> {
  @override
  void initState() {
    super.initState();
    // Load sold products when the view is initialized
    context.read<SMarketplaceViewModel>().add(LoadSoldProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Secondary Marketplace',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon!')),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.green[100],
      body: BlocConsumer<SMarketplaceViewModel, SMarketplaceState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.soldProducts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.soldProducts.isEmpty && !state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No products available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Check back later for new items',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<SMarketplaceViewModel>().add(RefreshSoldProductsEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio: 0.55, // Increased from 0.65 to make cards wider and prevent overflow
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.soldProducts.length,
                itemBuilder: (context, index) {
                  final product = state.soldProducts[index];
                  return _buildProductCard(context, product);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    return BlocProvider(
      create: (context) => serviceLocator<RequestTransferCubit>(),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    child: product.image.isNotEmpty
                        ? Builder(
                            builder: (context) {
                              String imageUrl = getBackendImageUrl(product.image);
                              return Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              );
                            },
                          )
                        : const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
                
                // Product Details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const SizedBox(height: 4),
                        
                        // Description (if available)
                        if (product.description != null && product.description!.isNotEmpty) ...[
                          Text(
                            product.description!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                        ],
                        
                        // Status Badge and Certified Icon
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: product.onSale ? Colors.green[100] : Colors.orange[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                product.onSale ? 'On Sale' : 'Sold',
                                style: TextStyle(
                                  color: product.onSale ? Colors.green[800] : Colors.orange[800],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (product.certified)
                              Icon(
                                Icons.verified,
                                color: Colors.blue[600],
                                size: 16,
                              ),
                          ],
                        ),
                        
                        const SizedBox(height: 6),
                        
                        // Original Price (crossed out)
                        Text(
                          'Original: \$${product.originalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        
                        // Current/Resale Price
                        if (product.resalePrice != null)
                          Text(
                            '\$${product.resalePrice!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        
                        const SizedBox(height: 4),
                        
                        // Owner Info
                        Text(
                          'Owner: ${product.owner?.firstName ?? 'Unknown'} ${product.owner?.lastName ?? ''}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        
                        const Spacer(),
                        
                        // Request Transfer Button (only this button now)
                        _buildRequestTransferButton(context, product),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Arrow button for navigation to details (positioned like in mobile_products_grid)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => _navigateToProductDetails(context, product.id),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestTransferButton(BuildContext context, ProductEntity product) {
    return BlocConsumer<RequestTransferCubit, RequestTransferState>(
      listener: (context, state) {
        // Handle success and error states
        if (state.runtimeType.toString().contains('Success')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transfer request sent successfully!'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        } else if (state.runtimeType.toString().contains('Failure') || 
                   state.runtimeType.toString().contains('Error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to send transfer request. Please try again.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.runtimeType.toString().contains('Loading');
        
        return SizedBox(
          width: double.infinity,
          height: 32,
          child: ElevatedButton.icon(
            onPressed: isLoading ? null : () => _requestTransfer(context, product),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            icon: isLoading
                ? const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(Icons.swap_horiz, size: 14),
            label: Text(
              isLoading ? 'Requesting...' : 'Request Transfer',
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
        );
      },
    );
  }

  void _navigateToProductDetails(BuildContext context, String productId) {
    // Validate product ID
    if (productId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid product ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Navigate to product details page using MaterialPageRoute
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          productId: productId,
          isOwned: false, // Set to false since this is from marketplace (not owned)
        ),
      ),
    );
  }

  void _requestTransfer(BuildContext context, ProductEntity product) {
    final cubit = context.read<RequestTransferCubit>();
    
    // Validate product ID
    if (product.id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid product ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Transfer'),
          content: Text(
            'Do you want to request transfer for "${product.name}"?\n\nPrice: \$${product.resalePrice?.toStringAsFixed(2) ?? 'N/A'}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Trigger the request transfer
                cubit.requestProductTransfer(product.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
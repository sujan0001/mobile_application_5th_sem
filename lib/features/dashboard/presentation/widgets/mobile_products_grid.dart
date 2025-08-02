// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
// import 'package:batch34_b/features/product_details/presentation/view/product_detail_view.dart';
// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';

// class MobileProductsGrid extends StatelessWidget {
//   const MobileProductsGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardViewModel, DashboardState>(
//       buildWhen: (previous, current) => 
//           previous.products != current.products || 
//           previous.isLoading != current.isLoading,
//       builder: (context, state) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Section header
//             _buildSectionHeader(context, state.products.length),
//             const SizedBox(height: 16),
            
//             // Products grid
//             if (state.isLoading)
//               _buildLoadingGrid()
//             else if (state.products.isEmpty)
//               _buildEmptyGrid()
//             else
//               _buildProductsGrid(state.products),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildSectionHeader(BuildContext context, int productCount) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             "Newly Listed Products",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               // Navigate to see all products
//             },
//             child: Text(
//               "See All",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[500],
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingGrid() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: 4, // Show 4 loading placeholders
//         itemBuilder: (context, index) {
//           return _buildLoadingProductCard();
//         },
//       ),
//     );
//   }

//   Widget _buildLoadingProductCard() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             // Loading image placeholder
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 shape: BoxShape.circle,
//               ),
//               child: const Center(
//                 child: CircularProgressIndicator(strokeWidth: 2),
//               ),
//             ),
//             const SizedBox(height: 12),
            
//             // Loading text placeholders
//             Container(
//               width: double.infinity,
//               height: 12,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               width: 80,
//               height: 10,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyGrid() {
//     return Container(
//       height: 200,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[200]!),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.inventory, size: 48, color: Colors.grey[400]),
//             const SizedBox(height: 12),
//             Text(
//               "No Products Available",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildProductsGrid(List<ProductEntity> products) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//           childAspectRatio: 0.75,
//         ),
//         itemCount: products.length,
//         itemBuilder: (context, index) {
//           return BlocProvider(
//             create: (context) => serviceLocator<RequestTransferCubit>(),
//             child: _buildProductCard(context, products[index]),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProductCard(BuildContext context, ProductEntity product) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Stack( // ✅ Added Stack here
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               children: [
//                 // Product image with NEW badge
//                 Stack(
//                   children: [
//                     Container(
//                       width: 80,
//                       height: 80,
//                       decoration: BoxDecoration(
//                         gradient: _getProductGradient(product),
//                         shape: BoxShape.circle,
//                       ),
//                       child: ClipOval(
//                         child: _buildProductImage(product),
//                       ),
//                     ),
                    
//                     // NEW badge
//                     Positioned(
//                       top: -2,
//                       right: -2,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 6,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Text(
//                           "NEW",
//                           style: TextStyle(
//                             fontSize: 10,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
                
//                 // Product details
//                 Expanded(
//                   child: Column(
//                     children: [
//                       // Product name
//                       Text(
//                         product.name ?? 'Unnamed Product',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 4),
                      
//                       // Category (derived from creator or collection)
//                       Text(
//                         _getProductCategory(product),
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[500],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 8),
                      
//                       // Price
//                       Text(
//                         "\$${_formatPrice(product.originalPrice)}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           // Action button (arrow) - Now properly positioned inside Stack
//           Positioned(
//             top: 8,
//             right: 8,
//             child: GestureDetector(
//               onTap: () => _navigateToProductDetails(context, product),
//               child: Container(
//                 width: 24,
//                 height: 24,
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.9),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.arrow_forward,
//                   size: 12,
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductImage(ProductEntity product) {
//     if (product.image != null && product.image!.isNotEmpty) {
//       return Image.network(
//         getBackendImageUrl(product.image!),
//         fit: BoxFit.cover,
//         width: 60,
//         height: 60,
//         errorBuilder: (context, error, stackTrace) {
//           return Icon(
//             Icons.inventory,
//             size: 30,
//             color: Colors.white.withOpacity(0.8),
//           );
//         },
//       );
//     } else {
//       return Icon(
//         Icons.inventory,
//         size: 30,
//         color: Colors.white.withOpacity(0.8),
//       );
//     }
//   }

//   LinearGradient _getProductGradient(ProductEntity product) {
//     // Generate different gradients based on product properties
//     if (product.certified == true) {
//       return const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF10B981), Color(0xFF059669)], // Green
//       );
//     } else if (product.onSale == true) {
//       return const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFFF59E0B), Color(0xFFD97706)], // Orange
//       );
//     } else if (product.name != null && 
//                (product.name!.toLowerCase().contains('tech') || 
//                 product.name!.toLowerCase().contains('smart'))) {
//       return const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)], // Purple
//       );
//     } else if (product.name != null && 
//                (product.name!.toLowerCase().contains('beauty') || 
//                 product.name!.toLowerCase().contains('skincare'))) {
//       return const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFFEC4899), Color(0xFFDB2777)], // Pink
//       );
//     } else {
//       return const LinearGradient(
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//         colors: [Color(0xFF14B8A6), Color(0xFF0D9488)], // Teal
//       );
//     }
//   }

//   String _getProductCategory(ProductEntity product) {
//     // Derive category from product name or creator role
//     final name = (product.name ?? '').toLowerCase();
//     if (name.contains('headphone') || name.contains('watch') || name.contains('tech')) {
//       return 'Electronics';
//     } else if (name.contains('bag') || name.contains('fashion') || name.contains('clothing')) {
//       return 'Fashion';
//     } else if (name.contains('beauty') || name.contains('skincare') || name.contains('cosmetic')) {
//       return 'Beauty';
//     } else if (name.contains('book') || name.contains('education')) {
//       return 'Education';
//     } else {
//       return 'General';
//     }
//   }

//   String _formatPrice(double? price) {
//     if (price == null) return '0.00';
//     return price.toStringAsFixed(2);
//   }

//   void _navigateToProductDetails(BuildContext context, ProductEntity product) {
//     if (product.id == null || product.id!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid product ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => ProductDetailView(
//           productId: product.id!,
//           isOwned: false,
//         ),
//       ),
//     );
//   }

//   void _requestTransfer(BuildContext context, ProductEntity product) {
//     final cubit = context.read<RequestTransferCubit>();
    
//     if (product.id == null || product.id!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid product ID'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: const Text(
//             'Request Transfer',
//             style: TextStyle(color: Colors.black87),
//           ),
//           content: Text(
//             'Do you want to request transfer for "${product.name ?? 'this product'}"?',
//             style: const TextStyle(color: Colors.black54),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(dialogContext).pop(),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//                 cubit.requestProductTransfer(product.id!);
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
import 'package:batch34_b/features/product_details/presentation/view/product_detail_view.dart';
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/utils/backend_image.dart';

class MobileProductsGrid extends StatelessWidget {
  const MobileProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      buildWhen: (previous, current) => 
          previous.products != current.products || 
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            _buildSectionHeader(context, state.products.length),
            const SizedBox(height: 16),
            
            // Products grid
            if (state.isLoading)
              _buildLoadingGrid()
            else if (state.products.isEmpty)
              _buildEmptyGrid()
            else
              _buildProductsGrid(state.products),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, int productCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Newly Listed Products",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Navigate to see all products
            },
            child: Text(
              "See All",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65, // Adjusted for taller cards
        ),
        itemCount: 4, // Show 4 loading placeholders
        itemBuilder: (context, index) {
          return _buildLoadingProductCard();
        },
      ),
    );
  }

  Widget _buildLoadingProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Loading image placeholder
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            const SizedBox(height: 12),
            
            // Loading text placeholders
            Container(
              width: double.infinity,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 80,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyGrid() {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              "No Products Available",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid(List<ProductEntity> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65, // Adjusted for taller cards with button
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return BlocProvider(
            create: (context) => serviceLocator<RequestTransferCubit>(),
            child: _buildProductCard(context, products[index]),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // Product image with NEW badge
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: _getProductGradient(product),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: _buildProductImage(product),
                      ),
                    ),
                    
                    // NEW badge
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "NEW",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Product details
                Expanded(
                  child: Column(
                    children: [
                      // Product name
                      Text(
                        product.name ?? 'Unnamed Product',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      
                      // Category (derived from creator or collection)
                      Text(
                        _getProductCategory(product),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      
                      // Price
                      Text(
                        "\$${_formatPrice(product.originalPrice)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Request Transfer Button
                      _buildRequestTransferButton(context, product),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action button (arrow) - Details navigation
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () => _navigateToProductDetails(context, product),
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
    );
  }

  Widget _buildRequestTransferButton(BuildContext context, ProductEntity product) {
    return BlocConsumer<RequestTransferCubit, RequestTransferState>(
      listener: (context, state) {
        // Handle success and error states
        if (state is RequestTransferSuccess && state.productId == product.id) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is RequestTransferFailure && state.productId == product.id) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is RequestTransferLoading && state.productId == product.id;
        
        return SizedBox(
          width: double.infinity,
          height: 32,
          child: ElevatedButton(
            onPressed: isLoading ? null : () => _requestTransfer(context, product),
            style: ElevatedButton.styleFrom(
              backgroundColor: isLoading ? Colors.grey : Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: isLoading ? 0 : 1,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 14,
                    width: 14,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Request Transfer',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildProductImage(ProductEntity product) {
    if (product.image != null && product.image!.isNotEmpty) {
      return Image.network(
        getBackendImageUrl(product.image!),
        fit: BoxFit.cover,
        width: 60,
        height: 60,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.inventory,
            size: 30,
            color: Colors.white.withOpacity(0.8),
          );
        },
      );
    } else {
      return Icon(
        Icons.inventory,
        size: 30,
        color: Colors.white.withOpacity(0.8),
      );
    }
  }

  LinearGradient _getProductGradient(ProductEntity product) {
    // Generate different gradients based on product properties
    if (product.certified == true) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF10B981), Color(0xFF059669)], // Green
      );
    } else if (product.onSale == true) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFF59E0B), Color(0xFFD97706)], // Orange
      );
    } else if (product.name != null && 
               (product.name!.toLowerCase().contains('tech') || 
                product.name!.toLowerCase().contains('smart'))) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)], // Purple
      );
    } else if (product.name != null && 
               (product.name!.toLowerCase().contains('beauty') || 
                product.name!.toLowerCase().contains('skincare'))) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFEC4899), Color(0xFFDB2777)], // Pink
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF14B8A6), Color(0xFF0D9488)], // Teal
      );
    }
  }

  String _getProductCategory(ProductEntity product) {
    // Derive category from product name or creator role
    final name = (product.name ?? '').toLowerCase();
    if (name.contains('headphone') || name.contains('watch') || name.contains('tech')) {
      return 'Electronics';
    } else if (name.contains('bag') || name.contains('fashion') || name.contains('clothing')) {
      return 'Fashion';
    } else if (name.contains('beauty') || name.contains('skincare') || name.contains('cosmetic')) {
      return 'Beauty';
    } else if (name.contains('book') || name.contains('education')) {
      return 'Education';
    } else {
      return 'General';
    }
  }

  String _formatPrice(double? price) {
    if (price == null) return '0.00';
    return price.toStringAsFixed(2);
  }

  void _navigateToProductDetails(BuildContext context, ProductEntity product) {
    if (product.id == null || product.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid product ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductDetailView(
          productId: product.id!,
          isOwned: false,
        ),
      ),
    );
  }

  void _requestTransfer(BuildContext context, ProductEntity product) {
    final cubit = context.read<RequestTransferCubit>();
    
    if (product.id == null || product.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid product ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Request Transfer',
            style: TextStyle(color: Colors.black87),
          ),
          content: Text(
            'Do you want to request transfer for "${product.name ?? 'this product'}"?',
            style: const TextStyle(color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                cubit.requestProductTransfer(product.id!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
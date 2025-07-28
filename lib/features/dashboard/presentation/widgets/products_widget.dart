// // widgets/products_widget.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';

// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardViewModel, DashboardState>(
//       buildWhen: (previous, current) => 
//           previous.products != current.products || 
//           previous.isLoading != current.isLoading,
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const _ProductsLoading();
//         }

//         if (state.products.isEmpty) {
//           return const _ProductsEmpty();
//         }

//         return _ProductsList(products: state.products);
//       },
//     );
//   }
// }

// class _ProductsLoading extends StatelessWidget {
//   const _ProductsLoading();

//   @override
//   Widget build(BuildContext context) {
//     return const Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               "Products",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             CircularProgressIndicator(),
//             SizedBox(height: 8),
//             Text("Loading products..."),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProductsEmpty extends StatelessWidget {
//   const _ProductsEmpty();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               "Products",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Icon(Icons.inventory, size: 48, color: Colors.grey[400]),
//             const SizedBox(height: 8),
//             Text(
//               "No products available",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProductsList extends StatelessWidget {
//   final List<ProductEntity> products;

//   const _ProductsList({required this.products});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Products",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${products.length}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ...products.map((product) => Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.only(bottom: 8),
//               decoration: BoxDecoration(
//                 color: Colors.orange[50],
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.orange[200]!),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.inventory, color: Colors.orange[600], size: 20),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       product.name,
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                 ],
//               ),
//             )).toList(),
//           ],
//         ),
//       ),
//     );
//   }
// }
// widgets/products_widget.dart - Fixed Version
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/dashboard/domain/entity/product_entity.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:batch34_b/core/utils/backend_image.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      buildWhen: (previous, current) => 
          previous.products != current.products || 
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const _ProductsLoading();
        }

        if (state.products.isEmpty) {
          return const _ProductsEmpty();
        }

        return _ProductsList(products: state.products);
      },
    );
  }
}

class _ProductsLoading extends StatelessWidget {
  const _ProductsLoading();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Loading products..."),
          ],
        ),
      ),
    );
  }
}

class _ProductsEmpty extends StatelessWidget {
  const _ProductsEmpty();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Products",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Icon(Icons.inventory, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              "No products available",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  final List<ProductEntity> products;

  const _ProductsList({required this.products});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Products",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${products.length}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...products.map((product) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.orange[100],
                      child: _buildProductImage(product),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? 'Unnamed Product',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        if (product.description != null && product.description!.isNotEmpty)
                          Text(
                            product.description!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 13,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 8),
                        // Price and status row
                        Row(
                          children: [
                            // Price
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '\$${_formatPrice(product.originalPrice)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.green[800],
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // On Sale badge
                            if (product.onSale == true)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'On Sale',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            // Certified badge
                            if (product.certified == true)
                              const Icon(
                                Icons.verified,
                                color: Colors.blue,
                                size: 16,
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Creator info
                        if (product.creator != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'by ${product.creator!.firstName ?? 'Unknown'}',
                              style: TextStyle(
                                color: Colors.orange[800],
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(ProductEntity product) {
    // Check if image exists and is not empty
    if (product.image != null && product.image!.isNotEmpty) {
      String imageUrl = getBackendImageUrl(product.image!);
      print('🖼️ Product Image URL: $imageUrl'); // Debug print
      
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('❌ Image loading error: $error'); // Debug print
          return Icon(
            Icons.inventory,
            color: Colors.orange[600],
            size: 28,
          );
        },
      );
    } else {
      // Show default icon if no image
      return Icon(
        Icons.inventory,
        color: Colors.orange[600],
        size: 28,
      );
    }
  }

  String _formatPrice(double? price) {
    if (price == null) return '0.00';
    return price.toStringAsFixed(2);
  }
}
// import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
// import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
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
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       elevation: 4,
//       color: Colors.grey.shade800,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: () {
//           context.read<SMarketplaceViewModel>().add(
//                 NavigateToProductDetailsEvent(
//                   context: context,
//                   productId: product.id,
//                 ),
//               );
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   color: Colors.grey.shade700,
//                   child: product.image.isNotEmpty
//                       ? Image.network(
//                           'http://localhost:5050/${product.image}',
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return const Icon(
//                               Icons.image_not_supported,
//                               color: Colors.grey,
//                               size: 40,
//                             );
//                           },
//                         )
//                       : const Icon(
//                           Icons.image,
//                           color: Colors.grey,
//                           size: 40,
//                         ),
//                 ),
//               ),
//               const SizedBox(width: 16),
              
//               // Product Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       product.name,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     if (product.description != null)
//                       Text(
//                         product.description!,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     const SizedBox(height: 8),
                    
//                     // Price Row
//                     Row(
//                       children: [
//                         Text(
//                           'Original: \$${product.originalPrice.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                             color: Colors.white54,
//                             fontSize: 12,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         if (product.resalePrice != null)
//                           Text(
//                             '\$${product.resalePrice!.toStringAsFixed(2)}',
//                             style: TextStyle(
//                               color: Theme.of(context).primaryColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
                    
//                     // Status and Owner
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 4,
//                           ),
//                           decoration: BoxDecoration(
//                             color: product.onSale ? Colors.green : Colors.orange,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: Text(
//                             product.onSale ? 'On Sale' : 'Sold',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const Spacer(),
//                         if (product.certified)
//                           const Icon(
//                             Icons.verified,
//                             color: Colors.blue,
//                             size: 20,
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Owner: ${product.owner?.firstName ?? 'Unknown'} ${product.owner?.lastName ?? ''}',
//                       style: const TextStyle(
//                         color: Colors.white60,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:batch34_b/features/s_marketplace/domain/entity/s_marketplace_entity.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_event.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_state.dart';
import 'package:batch34_b/features/s_marketplace/presentation/view_model/s_marketplace_view_model.dart';
import 'package:batch34_b/core/utils/backend_image.dart'; // Add this import
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.soldProducts.length,
              itemBuilder: (context, index) {
                final product = state.soldProducts[index];
                return _buildProductCard(context, product);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          context.read<SMarketplaceViewModel>().add(
                NavigateToProductDetailsEvent(
                  context: context,
                  productId: product.id,
                ),
              );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade700,
                  child: product.image.isNotEmpty
                      ? Builder(
                          builder: (context) {
                            // Debug prints
                            String imageUrl = getBackendImageUrl(product.image);
                            print('Product image path: ${product.image}');
                            print('Final URL: $imageUrl');
                            
                            return Image.network(
                              imageUrl, // Use utility function instead of hardcoded URL
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Image loading error: $error');
                                return const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                  size: 40,
                                );
                              },
                            );
                          },
                        )
                      : const Icon(
                          Icons.image,
                          color: Colors.grey,
                          size: 40,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    if (product.description != null)
                      Text(
                        product.description!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 8),
                    
                    // Price Row
                    Row(
                      children: [
                        Text(
                          'Original: \$${product.originalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (product.resalePrice != null)
                          Text(
                            '\$${product.resalePrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Status and Owner
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: product.onSale ? Colors.green : Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product.onSale ? 'On Sale' : 'Sold',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (product.certified)
                          const Icon(
                            Icons.verified,
                            color: Colors.blue,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Owner: ${product.owner?.firstName ?? 'Unknown'} ${product.owner?.lastName ?? ''}',
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
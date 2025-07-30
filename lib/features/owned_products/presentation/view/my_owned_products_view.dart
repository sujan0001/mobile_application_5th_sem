// import 'package:batch34_b/app/constant/api_endpoints.dart';
// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';
// import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_event.dart';
// import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_state.dart';
// import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_bloc.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../domain/entity/owned_product_entity.dart';

// class MyOwnedProductsView extends StatelessWidget {
//   const MyOwnedProductsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Owned Products'),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         foregroundColor: Colors.black,
//       ),
//       body: BlocProvider(
//         create: (context) => serviceLocator<OwnedProductsBloc>()
//           ..add(GetMyOwnedProductsEvent()),
//         child: const MyOwnedProductsBody(),
//       ),
//     );
//   }
// }

// class MyOwnedProductsBody extends StatelessWidget {
//   const MyOwnedProductsBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<OwnedProductsBloc, OwnedProductsState>(
//       listener: (context, state) {
//         if (state is ResellProductSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } else if (state is ResellProductError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.red,
//             ),
//           );
//         } else if (state is OwnedProductsError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is OwnedProductsLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is OwnedProductsLoaded) {
//           if (state.products.isEmpty) {
//             return const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.inventory_2_outlined,
//                     size: 64,
//                     color: Colors.grey,
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     'No owned products found',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return RefreshIndicator(
//             onRefresh: () async {
//               context.read<OwnedProductsBloc>().add(GetMyOwnedProductsEvent());
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1,
//                   childAspectRatio: 0.85,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: state.products.length,
//                 itemBuilder: (context, index) {
//                   final product = state.products[index];
//                   return ProductCard(product: product);
//                 },
//               ),
//             ),
//           );
//         } else if (state is ResellProductLoading) {
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CircularProgressIndicator(),
//                 SizedBox(height: 16),
//                 Text('Processing resell request...'),
//               ],
//             ),
//           );
//         }
        
//         return const Center(
//           child: Text('Something went wrong. Please try again.'),
//         );
//       },
//     );
//   }
// }

// class ProductCard extends StatelessWidget {
//   final OwnedProductEntity product;

//   const ProductCard({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Get the properly formatted image URL
//     final String imageUrl = getBackendImageUrl(product.image);
    
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//               ),
//               child: imageUrl.isNotEmpty
//                   ? Image.network(
//                       imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) {
//                         print('Image loading error: $error');
//                         print('Failed URL: $imageUrl');
//                         return const Center(
//                           child: Icon(
//                             Icons.image_not_supported,
//                             size: 50,
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       },
//                     )
//                   : const Center(
//                       child: Icon(
//                         Icons.image_not_supported,
//                         size: 50,
//                         color: Colors.grey,
//                       ),
//                     ),
//             ),
//           ),
          
//           // Product Details
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
                  
//                   if (product.description != null) ...[
//                     const SizedBox(height: 4),
//                     Text(
//                       product.description!,
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[600],
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
                  
//                   const SizedBox(height: 8),
//                   Text(
//                     'Collection: ${product.collection.title}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[500],
//                     ),
//                   ),
                  
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rs. ${product.originalPrice.toString()}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
                  
//                   Text(
//                     'By: ${product.creator.firstName} ${product.creator.lastName}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[500],
//                     ),
//                   ),
                  
//                   if (product.onSale == true && product.resalePrice != null) ...[
//                     const SizedBox(height: 4),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.orange[100],
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         'On Sale: Rs. ${product.resalePrice!.toString()}',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.orange[800],
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
                  
//                   const Spacer(),
                  
//                   // Action Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: product.onSale == true 
//                             ? null 
//                             : () => _showResellDialog(context, product.id),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: Text(
//                             product.onSale == true ? 'Listed for Sale' : 'Resell',
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () => _navigateToProductDetails(context, product.id),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.grey[800],
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text(
//                             'View Details',
//                             style: TextStyle(fontSize: 12),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showResellDialog(BuildContext context, String productId) {
//     final TextEditingController priceController = TextEditingController();
    
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Set Resale Price'),
//           content: TextField(
//             controller: priceController,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: 'Enter resale price',
//               hintText: 'e.g., 1500',
//               prefixText: 'Rs. ',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(dialogContext).pop(),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final price = double.tryParse(priceController.text);
//                 if (price != null && price > 0) {
//                   Navigator.of(dialogContext).pop();
//                   context.read<OwnedProductsBloc>().add(
//                     ResellProductEvent(productId: productId, resalePrice: price),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Please enter a valid price'),
//                       backgroundColor: Colors.red,
//                     ),
//                   );
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _navigateToProductDetails(BuildContext context, String productId) {
//     // Navigate to product details page
//     // You'll need to implement this based on your routing setup
//     Navigator.pushNamed(
//       context, 
//       '/product-details',
//       arguments: {'productId': productId, 'owned': true},
//     );
//   }
// }

import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/utils/backend_image.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_event.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_state.dart';
import 'package:batch34_b/features/owned_products/presentation/view_model/owned_products_bloc.dart';
import 'package:batch34_b/features/product_details/presentation/view/product_detail_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/owned_product_entity.dart';

class MyOwnedProductsView extends StatelessWidget {
  const MyOwnedProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Owned Products'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: BlocProvider(
        create: (context) => serviceLocator<OwnedProductsBloc>()
          ..add(GetMyOwnedProductsEvent()),
        child: const MyOwnedProductsBody(),
      ),
    );
  }
}

class MyOwnedProductsBody extends StatelessWidget {
  const MyOwnedProductsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnedProductsBloc, OwnedProductsState>(
      listener: (context, state) {
        if (state is ResellProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is ResellProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is OwnedProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is OwnedProductsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is OwnedProductsLoaded) {
          if (state.products.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No owned products found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context.read<OwnedProductsBloc>().add(GetMyOwnedProductsEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          );
        } else if (state is ResellProductLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Processing resell request...'),
              ],
            ),
          );
        }
        
        return const Center(
          child: Text('Something went wrong. Please try again.'),
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final OwnedProductEntity product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the properly formatted image URL
    final String imageUrl = getBackendImageUrl(product.image);
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Image loading error: $error');
                        print('Failed URL: $imageUrl');
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
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  if (product.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  const SizedBox(height: 8),
                  Text(
                    'Collection: ${product.collection.title}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  Text(
                    'Rs. ${product.originalPrice.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  
                  Text(
                    'By: ${product.creator.firstName} ${product.creator.lastName}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                  
                  if (product.onSale == true && product.resalePrice != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'On Sale: Rs. ${product.resalePrice!.toString()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                  
                  const Spacer(),
                  
                  // Action Buttons - Updated to use Row with 3 buttons
                  Column(
                    children: [
                      // First Row - Resell and View Details buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: product.onSale == true 
                                ? null 
                                : () => _showResellDialog(context, product.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: product.onSale == true ? Colors.grey : Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: Icon(
                                product.onSale == true ? Icons.check : Icons.sell,
                                size: 16,
                              ),
                              label: Text(
                                product.onSale == true ? 'Listed' : 'Resell',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _navigateToProductDetails(context, product.id),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.orange[700],
                                side: BorderSide(color: Colors.orange[300]!),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              icon: const Icon(Icons.visibility, size: 16),
                              label: const Text(
                                'Details',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showResellDialog(BuildContext context, String productId) {
    final TextEditingController priceController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Set Resale Price'),
          content: TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter resale price',
              hintText: 'e.g., 1500',
              prefixText: 'Rs. ',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final price = double.tryParse(priceController.text);
                if (price != null && price > 0) {
                  Navigator.of(dialogContext).pop();
                  context.read<OwnedProductsBloc>().add(
                    ResellProductEvent(productId: productId, resalePrice: price),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
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
          isOwned: true, // Set to true since this is from owned products list
        ),
      ),
    );
  }
}
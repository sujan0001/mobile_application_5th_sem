
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
// import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_view_model.dart';
// import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_state.dart';
// import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_event.dart';
// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';

// class ProductDetailView extends StatelessWidget {
//   final String productId;
//   final bool? isOwned;

//   const ProductDetailView({
//     super.key,
//     required this.productId,
//     this.isOwned,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => serviceLocator<ProductDetailViewModel>()
//         ..add(LoadProductDetailEvent(productId: productId)),
//       child: Scaffold(
//         backgroundColor: Colors.grey[50],
//         appBar: AppBar(
//           title: const Text('Product Details'),
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black87,
//           elevation: 1,
//         ),
//         body: BlocBuilder<ProductDetailViewModel, ProductDetailState>(
//           builder: (context, state) {
//             if (state is ProductDetailLoadingState) {
//               return const _LoadingWidget();
//             } else if (state is ProductDetailErrorState) {
//               return _ErrorWidget(message: state.message);
//             } else if (state is ProductDetailLoadedState) {
//               return _ProductDetailContent(
//                 product: state.product,
//                 isOwned: isOwned ?? false,
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }

// class _LoadingWidget extends StatelessWidget {
//   const _LoadingWidget();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(),
//           SizedBox(height: 16),
//           Text('Loading product details...'),
//         ],
//       ),
//     );
//   }
// }

// class _ErrorWidget extends StatelessWidget {
//   final String message;

//   const _ErrorWidget({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 64,
//               color: Colors.red[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Error',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red[600],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               message,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('Go Back'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ProductDetailContent extends StatelessWidget {
//   final ProductDetailEntity product;
//   final bool isOwned;

//   const _ProductDetailContent({
//     required this.product,
//     required this.isOwned,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image Section
//           _buildImageSection(),
          
//           // Product Info Section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildTitleSection(),
//                 const SizedBox(height: 16),
//                 _buildPriceSection(),
//                 const SizedBox(height: 16),
//                 _buildDescriptionSection(),
//                 const SizedBox(height: 16),
//                 _buildCreatorSection(),
//                 const SizedBox(height: 16),
//                 _buildCurrentOwnerSection(),
//                 const SizedBox(height: 16),
//                 _buildOwnershipHistorySection(),
//                 const SizedBox(height: 16),
//                 _buildStatusSection(),
//                 const SizedBox(height: 24),
//                 if (!isOwned) _buildActionButtons(context),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageSection() {
//     return Container(
//       width: double.infinity,
//       height: 300,
//       color: Colors.grey[200],
//       child: _buildProductImage(),
//     );
//   }

//   Widget _buildProductImage() {
//     if (product.image != null && product.image!.isNotEmpty) {
//       String imageUrl = getBackendImageUrl(product.image!);
      
//       return Image.network(
//         imageUrl,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Center(
//             child: Icon(
//               Icons.inventory,
//               color: Colors.grey[400],
//               size: 64,
//             ),
//           );
//         },
//       );
//     } else {
//       return Center(
//         child: Icon(
//           Icons.inventory,
//           color: Colors.grey[400],
//           size: 64,
//         ),
//       );
//     }
//   }

//   Widget _buildTitleSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           product.name ?? 'Unnamed Product',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         if (isOwned)
//           Container(
//             margin: const EdgeInsets.only(top: 8),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.green[100],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               'Owned',
//               style: TextStyle(
//                 color: Colors.green[800],
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildPriceSection() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           decoration: BoxDecoration(
//             color: Colors.green[100],
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             '\$${_formatPrice(product.originalPrice)}',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.green[800],
//             ),
//           ),
//         ),
//         const SizedBox(width: 12),
//         if (product.onSale == true)
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.red,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Text(
//               'On Sale',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         const Spacer(),
//         if (product.certified == true)
//           Row(
//             children: [
//               const Icon(
//                 Icons.verified,
//                 color: Colors.blue,
//                 size: 20,
//               ),
//               const SizedBox(width: 4),
//               Text(
//                 'Certified',
//                 style: TextStyle(
//                   color: Colors.blue[600],
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//       ],
//     );
//   }

//   Widget _buildDescriptionSection() {
//     if (product.description == null || product.description!.isEmpty) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Description',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           product.description!,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey[700],
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCreatorSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Creator',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.orange[50],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.orange[200]!),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.orange[200],
//                 child: Text(
//                   product.creator.firstName.isNotEmpty
//                       ? product.creator.firstName[0].toUpperCase()
//                       : 'U',
//                   style: TextStyle(
//                     color: Colors.orange[800],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${product.creator.firstName} ${product.creator.lastName}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       product.creator.email,
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCurrentOwnerSection() {
//     if (product.owner == null) {
//       return const SizedBox.shrink();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Current Owner',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.purple[50],
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.purple[200]!),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.purple[200],
//                 child: Text(
//                   product.owner!.firstName.isNotEmpty
//                       ? product.owner!.firstName[0].toUpperCase()
//                       : 'U',
//                   style: TextStyle(
//                     color: Colors.purple[800],
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${product.owner!.firstName} ${product.owner!.lastName}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       product.owner!.email,
//                       style: TextStyle(
//                         color: Colors.grey[600],
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.purple[100],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   'Owner',
//                   style: TextStyle(
//                     color: Colors.purple[800],
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOwnershipHistorySection() {
//     // Check if soldHistory exists and has items
//     if (product.soldHistory.isEmpty) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Ownership History',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             child: Column(
//               children: [
//                 Icon(
//                   Icons.history,
//                   color: Colors.grey[400],
//                   size: 32,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'No ownership history yet',
//                   style: TextStyle(
//                     color: Colors.grey[600],
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 Text(
//                   'This product has not been sold yet',
//                   style: TextStyle(
//                     color: Colors.grey[500],
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text(
//               'Ownership History',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(width: 8),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 '${product.soldHistory.length}',
//                 style: TextStyle(
//                   color: Colors.blue[800],
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey[200]!),
//           ),
//           child: ListView.separated(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: product.soldHistory.length,
//             separatorBuilder: (context, index) => Divider(
//               color: Colors.grey[200],
//               height: 1,
//             ),
//             itemBuilder: (context, index) {
//               final sale = product.soldHistory[index];
//               final isLatest = index == 0;
              
//               return Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         color: isLatest ? Colors.green[100] : Colors.grey[100],
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: isLatest ? Colors.green[300]! : Colors.grey[300]!,
//                           width: 2,
//                         ),
//                       ),
//                       child: Icon(
//                         isLatest ? Icons.person : Icons.history,
//                         color: isLatest ? Colors.green[700] : Colors.grey[600],
//                         size: 20,
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'Sale #${product.soldHistory.length - index}',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               if (isLatest) ...[
//                                 const SizedBox(width: 8),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 6,
//                                     vertical: 2,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green[100],
//                                     borderRadius: BorderRadius.circular(6),
//                                   ),
//                                   child: Text(
//                                     'Latest',
//                                     style: TextStyle(
//                                       color: Colors.green[800],
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ],
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             'Price: ${_formatPrice(sale.price)}',
//                             style: TextStyle(
//                               color: Colors.grey[700],
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             _formatDate(sale.date),
//                             style: TextStyle(
//                               color: Colors.grey[500],
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Status',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black87,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: [
//             _buildStatusChip(
//               'Available',
//               Colors.green,
//               true,
//             ),
//             if (product.onSale == true)
//               _buildStatusChip(
//                 'On Sale',
//                 Colors.red,
//                 true,
//               ),
//             if (product.certified == true)
//               _buildStatusChip(
//                 'Certified',
//                 Colors.blue,
//                 true,
//               ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildStatusChip(String label, Color color, bool isActive) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: isActive ? color.withOpacity(0.1) : Colors.grey[200],
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: isActive ? color : Colors.grey[400]!,
//         ),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: isActive ? color : Colors.grey[600],
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButtons(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 48,
//           child: ElevatedButton.icon(
//             onPressed: () {
//               // TODO: Implement purchase logic
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Purchase functionality coming soon!'),
//                   backgroundColor: Colors.blue,
//                 ),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.blue,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             icon: const Icon(Icons.shopping_cart),
//             label: const Text(
//               'Purchase Product',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//         const SizedBox(height: 12),
//         SizedBox(
//           width: double.infinity,
//           height: 48,
//           child: OutlinedButton.icon(
//             onPressed: () {
//               // TODO: Implement add to wishlist logic
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Added to wishlist!'),
//                   backgroundColor: Colors.green,
//                 ),
//               );
//             },
//             style: OutlinedButton.styleFrom(
//               foregroundColor: Colors.blue,
//               side: const BorderSide(color: Colors.blue),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             icon: const Icon(Icons.favorite_border),
//             label: const Text(
//               'Add to Wishlist',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   String _formatPrice(double? price) {
//     if (price == null) return '0.00';
//     return price.toStringAsFixed(2);
//   }

//   String _formatDate(DateTime date) {
//     try {
//       final now = DateTime.now();
//       final difference = now.difference(date);

//       if (difference.inDays > 365) {
//         return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
//       } else if (difference.inDays > 30) {
//         return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
//       } else if (difference.inDays > 0) {
//         return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
//       } else if (difference.inHours > 0) {
//         return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
//       } else {
//         return 'Just now';
//       }
//     } catch (e) {
//       return date.toString();
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/product_details/domain/entity/product_detail_entity.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_view_model.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_state.dart';
import 'package:batch34_b/features/product_details/presentation/view_model/product_detail_event.dart';
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/utils/backend_image.dart';

class ProductDetailView extends StatelessWidget {
  final String productId;
  final bool? isOwned;

  const ProductDetailView({
    super.key,
    required this.productId,
    this.isOwned,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ProductDetailViewModel>()
        ..add(LoadProductDetailEvent(productId: productId)),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Product Details'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 1,
        ),
        body: BlocBuilder<ProductDetailViewModel, ProductDetailState>(
          builder: (context, state) {
            if (state is ProductDetailLoadingState) {
              return const _LoadingWidget();
            } else if (state is ProductDetailErrorState) {
              return _ErrorWidget(message: state.message);
            } else if (state is ProductDetailLoadedState) {
              return _ProductDetailContent(
                product: state.product,
                isOwned: isOwned ?? false,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading product details...'),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Error',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  final ProductDetailEntity product;
  final bool isOwned;

  const _ProductDetailContent({
    required this.product,
    required this.isOwned,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image Section
          _buildImageSection(),
          
          // Product Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitleSection(),
                const SizedBox(height: 16),
                _buildPriceSection(),
                const SizedBox(height: 16),
                _buildDescriptionSection(),
                const SizedBox(height: 16),
                _buildCreatorSection(),
                const SizedBox(height: 16),
                _buildCurrentOwnerSection(),
                const SizedBox(height: 16),
                _buildOwnershipHistorySection(),
                const SizedBox(height: 16),
                _buildStatusSection(),
                const SizedBox(height: 24),
                if (!isOwned) _buildActionButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.grey[200],
      child: _buildProductImage(),
    );
  }

  Widget _buildProductImage() {
    if (product.image != null && product.image!.isNotEmpty) {
      String imageUrl = getBackendImageUrl(product.image!);
      
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.inventory,
              color: Colors.grey[400],
              size: 64,
            ),
          );
        },
      );
    } else {
      return Center(
        child: Icon(
          Icons.inventory,
          color: Colors.grey[400],
          size: 64,
        ),
      );
    }
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? 'Unnamed Product',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (isOwned)
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Owned',
              style: TextStyle(
                color: Colors.green[800],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '\$${_formatPrice(product.originalPrice)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ),
        const SizedBox(width: 12),
        if (product.onSale == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'On Sale',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        const Spacer(),
        if (product.certified == true)
          Row(
            children: [
              const Icon(
                Icons.verified,
                color: Colors.blue,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                'Certified',
                style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    if (product.description == null || product.description!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildCreatorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Creator',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange[200]!),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.orange[200],
                child: Text(
                  product.creator.firstName.isNotEmpty
                      ? product.creator.firstName[0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.creator.firstName} ${product.creator.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      product.creator.email,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentOwnerSection() {
    if (product.owner == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Current Owner',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.purple[200]!),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple[200],
                child: Text(
                  product.owner!.firstName.isNotEmpty
                      ? product.owner!.firstName[0].toUpperCase()
                      : 'U',
                  style: TextStyle(
                    color: Colors.purple[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${product.owner!.firstName} ${product.owner!.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      product.owner!.email,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Owner',
                  style: TextStyle(
                    color: Colors.purple[800],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOwnershipHistorySection() {
    // Check if soldHistory exists and has items
    if (product.soldHistory.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ownership History',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.history,
                  color: Colors.grey[400],
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  'No ownership history yet',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'This product has not been sold yet',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Ownership History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${product.soldHistory.length}',
                style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: product.soldHistory.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[200],
              height: 1,
            ),
            itemBuilder: (context, index) {
              final sale = product.soldHistory[index];
              final isLatest = index == 0;
              
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isLatest ? Colors.green[100] : Colors.grey[100],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isLatest ? Colors.green[300]! : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        isLatest ? Icons.person : Icons.history,
                        color: isLatest ? Colors.green[700] : Colors.grey[600],
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Sale #${product.soldHistory.length - index}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              if (isLatest) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Latest',
                                    style: TextStyle(
                                      color: Colors.green[800],
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Price: ${_formatPrice(sale.price)}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(sale.date),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStatusChip(
              'Available',
              Colors.green,
              true,
            ),
            if (product.onSale == true)
              _buildStatusChip(
                'On Sale',
                Colors.red,
                true,
              ),
            if (product.certified == true)
              _buildStatusChip(
                'Certified',
                Colors.blue,
                true,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label, Color color, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? color.withOpacity(0.1) : Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? color : Colors.grey[400]!,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? color : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement purchase logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchase functionality coming soon!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.shopping_cart),
            label: const Text(
              'Purchase Product',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement add to wishlist logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to wishlist!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.favorite_border),
            label: const Text(
              'Add to Wishlist',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  String _formatPrice(double? price) {
    if (price == null) return '0.00';
    return price.toStringAsFixed(2);
  }

  String _formatDate(DateTime date) {
    try {
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return date.toString();
    }
  }
}
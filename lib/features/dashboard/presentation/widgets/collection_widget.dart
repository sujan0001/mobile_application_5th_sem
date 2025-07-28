import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:batch34_b/core/utils/backend_image.dart';

class CollectionsWidget extends StatelessWidget {
  const CollectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      buildWhen: (previous, current) => 
          previous.collections != current.collections || 
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const _CollectionsLoading();
        }

        if (state.collections.isEmpty) {
          return const _CollectionsEmpty();
        }

        return _CollectionsList(collections: state.collections);
      },
    );
  }
}

class _CollectionsLoading extends StatelessWidget {
  const _CollectionsLoading();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Collections",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Loading collections..."),
          ],
        ),
      ),
    );
  }
}

class _CollectionsEmpty extends StatelessWidget {
  const _CollectionsEmpty();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Collections",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Icon(Icons.collections, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              "No collections available",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionsList extends StatelessWidget {
  final List<CollectionEntity> collections;

  const _CollectionsList({required this.collections});

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
                  "Collections",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${collections.length}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...collections.map((collection) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  // Collection Cover Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue[100],
                      child: collection.coverImage != null && collection.coverImage!.isNotEmpty
                          ? Image.network(
                              getBackendImageUrl(collection.coverImage!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.collections,
                                  color: Colors.blue[600],
                                  size: 24,
                                );
                              },
                            )
                          : Icon(
                              Icons.collections,
                              color: Colors.blue[600],
                              size: 24,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          collection.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (collection.description != null)
                          Text(
                            collection.description!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (collection.certified)
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
                                  'Certified',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            if (collection.creator != null)
                              Text(
                                'by ${collection.creator.firstName}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ],
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
}
// widgets/collections_widget.dart - Fixed Version
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';

// class CollectionsWidget extends StatelessWidget {
//   const CollectionsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardViewModel, DashboardState>(
//       buildWhen: (previous, current) => 
//           previous.collections != current.collections || 
//           previous.isLoading != current.isLoading,
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const _CollectionsLoading();
//         }

//         if (state.collections.isEmpty) {
//           return const _CollectionsEmpty();
//         }

//         return _CollectionsList(collections: state.collections);
//       },
//     );
//   }
// }

// class _CollectionsLoading extends StatelessWidget {
//   const _CollectionsLoading();

//   @override
//   Widget build(BuildContext context) {
//     return const Card(
//       child: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               "Collections",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             CircularProgressIndicator(),
//             SizedBox(height: 8),
//             Text("Loading collections..."),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _CollectionsEmpty extends StatelessWidget {
//   const _CollectionsEmpty();

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const Text(
//               "Collections",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Icon(Icons.collections, size: 48, color: Colors.grey[400]),
//             const SizedBox(height: 8),
//             Text(
//               "No collections available",
//               style: TextStyle(color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _CollectionsList extends StatelessWidget {
//   final List<CollectionEntity> collections;

//   const _CollectionsList({required this.collections});

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
//                   "Collections",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "${collections.length}",
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey[600],
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ...collections.map((collection) => Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               margin: const EdgeInsets.only(bottom: 8),
//               decoration: BoxDecoration(
//                 color: Colors.blue[50],
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.blue[200]!),
//               ),
//               child: Row(
//                 children: [
//                   // Collection Cover Image
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(8),
//                     child: Container(
//                       width: 60,
//                       height: 60,
//                       color: Colors.blue[100],
//                       child: _buildCollectionImage(collection),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           collection.title ?? 'Untitled Collection',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 16,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 6),
//                         if (collection.description != null && collection.description!.isNotEmpty)
//                           Text(
//                             collection.description!,
//                             style: TextStyle(
//                               color: Colors.grey[600],
//                               fontSize: 13,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             // Creator info
//                             if (collection.creator != null)
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 8,
//                                   vertical: 4,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue[100],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: Text(
//                                   'by ${collection.creator!.firstName ?? 'Unknown'}',
//                                   style: TextStyle(
//                                     color: Colors.blue[800],
//                                     fontSize: 11,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             const Spacer(),
//                             // Certified badge
//                             if (collection.certified == true)
//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 6,
//                                   vertical: 2,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: Colors.green,
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: const Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.verified,
//                                       color: Colors.white,
//                                       size: 12,
//                                     ),
//                                     SizedBox(width: 2),
//                                     Text(
//                                       'Verified',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ],
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

//   Widget _buildCollectionImage(CollectionEntity collection) {
//     // Check if coverImage exists and is not empty
//     if (collection.coverImage != null && collection.coverImage!.isNotEmpty) {
//       String imageUrl = getBackendImageUrl(collection.coverImage!);
//       print('🖼️ Collection Image URL: $imageUrl'); // Debug print
      
//       return Image.network(
//         imageUrl,
//         fit: BoxFit.cover,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress == null) return child;
//           return const Center(
//             child: CircularProgressIndicator(strokeWidth: 2),
//           );
//         },
//         errorBuilder: (context, error, stackTrace) {
//           print('❌ Image loading error: $error'); // Debug print
//           return Icon(
//             Icons.collections,
//             color: Colors.blue[600],
//             size: 28,
//           );
//         },
//       );
//     } else {
//       // Show default icon if no image
//       return Icon(
//         Icons.collections,
//         color: Colors.blue[600],
//         size: 28,
//       );
//     }
//   }
// }
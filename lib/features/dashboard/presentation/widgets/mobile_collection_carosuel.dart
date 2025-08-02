// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
// import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
// import 'package:batch34_b/core/utils/backend_image.dart';

// class MobileCollectionCarousel extends StatefulWidget {
//   const MobileCollectionCarousel({super.key});

//   @override
//   State<MobileCollectionCarousel> createState() => _MobileCollectionCarouselState();
// }

// class _MobileCollectionCarouselState extends State<MobileCollectionCarousel> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   Timer? _timer;

//   // Define 5 different gradient colors
//   final List<List<Color>> _gradientColorsList = [
//     [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Purple-Blue
//     [const Color(0xFF11998E), const Color(0xFF38EF7D)], // Teal-Green
//     [const Color(0xFFFC466B), const Color(0xFF3F5EFB)], // Pink-Blue
//     [const Color(0xFFFFCE00), const Color(0xFFFF8C00)], // Yellow-Orange
//     [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Blue-Purple
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _startAutoSlide();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startAutoSlide() {
//     _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
//       if (_pageController.hasClients) {
//         final collectionsLength = context.read<DashboardViewModel>().state.collections.length;
//         if (collectionsLength > 0) {
//           final nextPage = (_currentPage + 1) % collectionsLength;
//           _pageController.animateToPage(
//             nextPage,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.easeInOut,
//           );
//         }
//       }
//     });
//   }

//   void _onPageChanged(int page) {
//     setState(() {
//       _currentPage = page;
//     });
//   }

//   void _onIndicatorTap(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DashboardViewModel, DashboardState>(
//       buildWhen: (previous, current) => 
//           previous.collections != current.collections || 
//           previous.isLoading != current.isLoading,
//       builder: (context, state) {
//         if (state.isLoading) {
//           return _buildLoadingCarousel();
//         }

//         if (state.collections.isEmpty) {
//           return _buildEmptyCarousel();
//         }

//         return _buildCollectionCarousel(state.collections);
//       },
//     );
//   }

//   Widget _buildLoadingCarousel() {
//     return Container(
//       height: 180,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(color: Colors.white),
//             SizedBox(height: 12),
//             Text(
//               "Loading Collections...",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyCarousel() {
//     return Container(
//       height: 180,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.collections, size: 48, color: Colors.grey[400]),
//             const SizedBox(height: 12),
//             Text(
//               "No Collections Available",
//               style: TextStyle(
//                 color: Colors.grey[600],
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCollectionCarousel(List<CollectionEntity> collections) {
//     return Container(
//       height: 180,
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       child: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             onPageChanged: _onPageChanged,
//             itemCount: collections.length,
//             itemBuilder: (context, index) {
//               return _buildCollectionSlide(collections[index], index);
//             },
//           ),
//           // Indicators
//           if (collections.length > 1)
//             Positioned(
//               bottom: 16,
//               left: 0,
//               right: 0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   collections.length,
//                   (index) => GestureDetector(
//                     onTap: () => _onIndicatorTap(index),
//                     child: Container(
//                       width: 8,
//                       height: 8,
//                       margin: const EdgeInsets.symmetric(horizontal: 4),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: _currentPage == index 
//                             ? Colors.black87 
//                             : Colors.black26,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCollectionSlide(CollectionEntity collection, int index) {
//     // Get gradient colors based on index
//     List<Color> gradientColors = _getGradientColors(collection, index);

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: gradientColors,
//         ),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 2,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Certified/New badge
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFEF3C7),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       collection.certified ? "CERTIFIED" : "NEW",
//                       style: const TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF92400E),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
                  
//                   // Collection title
//                   Text(
//                     collection.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
                  
//                   // Collection description
//                   if (collection.description != null && collection.description!.isNotEmpty)
//                     Text(
//                       collection.description!,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: Colors.white70,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   const SizedBox(height: 8),
                  
//                   // Creator name - Added this part
//                   if (collection.creator != null)
//                     Text(
//                       'by ${collection.creator!.firstName}',
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.white60,
//                         fontStyle: FontStyle.italic,
//                       ),
//                     ),
//                   const SizedBox(height: 12),
                  
//                   // Discover more button
//                   GestureDetector(
//                     onTap: () {
//                       // Add navigation to collection details
//                     },
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           "Discover More",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(width: 4),
//                         Icon(
//                           Icons.arrow_forward,
//                           size: 16,
//                           color: Colors.white,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
            
//             // Collection image
//             Expanded(
//               flex: 1,
//               child: _buildCollectionImage(collection),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCollectionImage(CollectionEntity collection) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white.withOpacity(0.2),
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: collection.coverImage != null && collection.coverImage!.isNotEmpty
//             ? Image.network(
//                 getBackendImageUrl(collection.coverImage!),
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Icon(
//                     Icons.collections,
//                     size: 40,
//                     color: Colors.white.withOpacity(0.8),
//                   );
//                 },
//               )
//             : Icon(
//                 Icons.collections,
//                 size: 40,
//                 color: Colors.white.withOpacity(0.8),
//               ),
//       ),
//     );
//   }

//   List<Color> _getGradientColors(CollectionEntity collection, int index) {
//     // For certified collections, always use green gradient
//     if (collection.certified) {
//       return [const Color(0xFF10B981), const Color(0xFF059669)]; // Green gradient
//     }
    
//     // For other collections, cycle through the predefined gradients
//     return _gradientColorsList[index % _gradientColorsList.length];
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/dashboard/domain/entity/collection_entity.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';
import 'package:batch34_b/core/utils/backend_image.dart';

class MobileCollectionCarousel extends StatefulWidget {
  const MobileCollectionCarousel({super.key});

  @override
  State<MobileCollectionCarousel> createState() => _MobileCollectionCarouselState();
}

class _MobileCollectionCarouselState extends State<MobileCollectionCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  // Define 5 different gradient colors
  final List<List<Color>> _gradientColorsList = [
    [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Purple-Blue
    [const Color(0xFF11998E), const Color(0xFF38EF7D)], // Teal-Green
    [const Color(0xFFFC466B), const Color(0xFF3F5EFB)], // Pink-Blue
    [const Color(0xFFFFCE00), const Color(0xFFFF8C00)], // Yellow-Orange
    [const Color(0xFF667EEA), const Color(0xFF764BA2)], // Blue-Purple
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        final collectionsLength = context.read<DashboardViewModel>().state.collections.length;
        if (collectionsLength > 0) {
          final nextPage = (_currentPage + 1) % collectionsLength;
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onIndicatorTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      buildWhen: (previous, current) => 
          previous.collections != current.collections || 
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return _buildLoadingCarousel();
        }

        if (state.collections.isEmpty) {
          return _buildEmptyCarousel();
        }

        return _buildCollectionCarousel(state.collections);
      },
    );
  }

  Widget _buildLoadingCarousel() {
    return Container(
      height: 200, // Increased to match main carousel
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 12),
            Text(
              "Loading Collections...",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCarousel() {
    return Container(
      height: 200, // Increased to match main carousel
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3F4F6), Color(0xFFE5E7EB)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              "No Collections Available",
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCarousel(List<CollectionEntity> collections) {
    return Container(
      height: 200, // Increased height to accommodate content
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: collections.length,
            itemBuilder: (context, index) {
              return _buildCollectionSlide(collections[index], index);
            },
          ),
          // Indicators
          if (collections.length > 1)
            Positioned(
              bottom: 12, // Reduced bottom padding
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  collections.length,
                  (index) => GestureDetector(
                    onTap: () => _onIndicatorTap(index),
                    child: Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index 
                            ? Colors.black87 
                            : Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCollectionSlide(CollectionEntity collection, int index) {
    // Get gradient colors based on index
    List<Color> gradientColors = _getGradientColors(collection, index);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20), // Reduced from 24 to 20
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Certified/New badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4, // Reduced from 6 to 4
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      collection.certified ? "CERTIFIED" : "NEW",
                      style: const TextStyle(
                        fontSize: 12, // Keep original size
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF92400E),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Reduced from 12 to 8
                  
                  // Collection title
                  Text(
                    collection.title,
                    style: const TextStyle(
                      fontSize: 18, // Keep original size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1, // Reduced from 2 to 1 to save space
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3), // Reduced from 4 to 3
                  
                  // Collection description
                  if (collection.description != null && collection.description!.isNotEmpty)
                    Text(
                      collection.description!,
                      style: const TextStyle(
                        fontSize: 14, // Keep original size
                        color: Colors.white70,
                      ),
                      maxLines: 1, // Reduced from 2 to 1 to save space
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 4), // Reduced from 8 to 4
                  
                  // Creator name
                  if (collection.creator != null)
                    Text(
                      'by ${collection.creator!.firstName}',
                      style: const TextStyle(
                        fontSize: 12, // Keep original size
                        color: Colors.white60,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  const SizedBox(height: 8), // Reduced from 12 to 8
                  
                  // Discover more button
                  GestureDetector(
                    onTap: () {
                      // Add navigation to collection details
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Discover More",
                          style: TextStyle(
                            fontSize: 14, // Keep original size
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward,
                          size: 16, // Keep original size
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Collection image
            Expanded(
              flex: 1,
              child: _buildCollectionImage(collection),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionImage(CollectionEntity collection) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: collection.coverImage != null && collection.coverImage!.isNotEmpty
            ? Image.network(
                getBackendImageUrl(collection.coverImage!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.collections,
                    size: 40,
                    color: Colors.white.withOpacity(0.8),
                  );
                },
              )
            : Icon(
                Icons.collections,
                size: 40,
                color: Colors.white.withOpacity(0.8),
              ),
      ),
    );
  }

  List<Color> _getGradientColors(CollectionEntity collection, int index) {
    // For certified collections, always use green gradient
    if (collection.certified) {
      return [const Color(0xFF10B981), const Color(0xFF059669)]; // Green gradient
    }
    
    // For other collections, cycle through the predefined gradients
    return _gradientColorsList[index % _gradientColorsList.length];
  }
}
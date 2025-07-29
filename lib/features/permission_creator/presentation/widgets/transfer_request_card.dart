import 'package:batch34_b/core/utils/backend_image.dart';
import 'package:batch34_b/features/permission_creator/domain/entity/transfer_request_entity.dart';
import 'package:flutter/material.dart';


class TransferRequestCard extends StatelessWidget {
  final TransferRequestEntity request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const TransferRequestCard({
    Key? key,
    required this.request,
    required this.onAccept,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // // Product Image
            // if (request.image.isNotEmpty)
            //   Container(
            //     height: 120,
            //     width: double.infinity,
            //     margin: const EdgeInsets.only(bottom: 12),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(8),
            //       image: DecorationImage(
            //         image: NetworkImage('http://localhost:5050/${request.image}'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // Product Image
            if (request.image.isNotEmpty)
              Container(
                height: 120,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(getBackendImageUrl(request.image)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            
            // Product Name
            Text(
              request.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Description
            if (request.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  request.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            
            // Collection
            Row(
              children: [
                const Text('Collection: '),
                Text(
                  request.collection?.title ?? 'N/A',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Requested by
            Row(
              children: [
                const Text('Requested by: '),
                Text(
                  '${request.pendingTransfer.buyer.firstName} ${request.pendingTransfer.buyer.lastName}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Price Information
            Row(
              children: [
                const Text('Price: '),
                Text(
                  // previously it was like this :'\${request.resalePrice ?? request.originalPrice}', i removed the slash
                  '${request.resalePrice ?? request.originalPrice}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                if (request.resalePrice != null && request.resalePrice != request.originalPrice)
                  Text(
                    ' (source price: ${request.originalPrice})',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            
            // Buyer Email
            Row(
              children: [
                const Text('Email: '),
                Text(
                  request.pendingTransfer.buyer.email,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Accept'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDecline,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

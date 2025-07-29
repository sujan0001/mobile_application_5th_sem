import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_cubit.dart';
import 'package:batch34_b/features/s_marketplace/presentation/cubit/request_transfer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RequestTransferButtonWidget extends StatelessWidget {
  final String productId;
  final String productName;
  final VoidCallback? onSuccess;
  final VoidCallback? onFailure;

  const RequestTransferButtonWidget({
    Key? key,
    required this.productId,
    required this.productName,
    this.onSuccess,
    this.onFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestTransferCubit, RequestTransferState>(
      listener: (context, state) {
        if (state is RequestTransferSuccess && state.productId == productId) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
          // Call success callback if provided
          onSuccess?.call();
        } else if (state is RequestTransferFailure && state.productId == productId) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          // Call failure callback if provided
          onFailure?.call();
        }
      },
      builder: (context, state) {
        final isLoading = state is RequestTransferLoading && state.productId == productId;

        return SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: isLoading 
                ? null 
                : () => _handleRequestTransfer(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: isLoading ? Colors.grey : Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: isLoading ? 0 : 2,
            ),
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('Requesting...'),
                    ],
                  )
                : const Text(
                    'Request Purchase',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _handleRequestTransfer(BuildContext context) {
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirm Request'),
        content: Text('Do you want to request to purchase "$productName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              // Trigger the request
              context.read<RequestTransferCubit>().requestProductTransfer(productId);
            },
            child: const Text('Request'),
          ),
        ],
      ),
    );
  }
}

// Alternative: Simple button without confirmation dialog
class SimpleRequestTransferButton extends StatelessWidget {
  final String productId;
  final VoidCallback? onSuccess;
  final VoidCallback? onFailure;

  const SimpleRequestTransferButton({
    Key? key,
    required this.productId,
    this.onSuccess,
    this.onFailure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RequestTransferCubit, RequestTransferState>(
      listener: (context, state) {
        if (state is RequestTransferSuccess && state.productId == productId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.green),
          );
          onSuccess?.call();
        } else if (state is RequestTransferFailure && state.productId == productId) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
          onFailure?.call();
        }
      },
      builder: (context, state) {
        final isLoading = state is RequestTransferLoading && state.productId == productId;

        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () => context.read<RequestTransferCubit>().requestProductTransfer(productId),
          child: Text(isLoading ? 'Requesting...' : 'Request Purchase'),
        );
      },
    );
  }
}
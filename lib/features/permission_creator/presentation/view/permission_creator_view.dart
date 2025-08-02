import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/permission_creator_view_model.dart';
import '../widgets/transfer_request_card.dart';

class PermissionCreatorView extends StatefulWidget {
  const PermissionCreatorView({Key? key}) : super(key: key);

  @override
  State<PermissionCreatorView> createState() => _PermissionCreatorViewState();
}

class _PermissionCreatorViewState extends State<PermissionCreatorView> {
  @override
  void initState() {
    super.initState();
    // Load data when view is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PermissionCreatorViewModel>().loadTransferRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Transfer Requests',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<PermissionCreatorViewModel>().loadTransferRequests();
            },
          ),
        ],
      ),
      body: Consumer<PermissionCreatorViewModel>(
        builder: (context, viewModel, child) {
          return _buildBody(viewModel);
        },
      ),
    );
  }

  Widget _buildBody(PermissionCreatorViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (viewModel.hasError) {
      return _buildErrorState(viewModel);
    }

    if (!viewModel.hasRequests) {
      return _buildEmptyState();
    }

    return _buildRequestsList(viewModel);
  }

  Widget _buildErrorState(PermissionCreatorViewModel viewModel) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              'Error: ${viewModel.errorMessage}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => viewModel.loadTransferRequests(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'No pending requests.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You don\'t have any incoming transfer requests at the moment.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(PermissionCreatorViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () => viewModel.loadTransferRequests(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.requests.length,
        itemBuilder: (context, index) {
          final request = viewModel.requests[index];
          return TransferRequestCard(
            request: request,
            onAccept: () => _showConfirmationDialog(
              context,
              'Accept Transfer',
              'Are you sure you want to accept this transfer request?',
              () => viewModel.acceptRequest(request.id),
            ),
            onDecline: () => _showConfirmationDialog(
              context,
              'Decline Transfer',
              'Are you sure you want to decline this transfer request?',
              () => viewModel.declineRequest(request.id),
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }
}

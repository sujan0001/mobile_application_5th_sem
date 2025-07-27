// dashboard_page_view.dart - Complete Fix
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/dashboard_state.dart';

class DashboardPageView extends StatefulWidget {
  const DashboardPageView({super.key});

  @override
  State<DashboardPageView> createState() => _DashboardPageViewState();
}

class _DashboardPageViewState extends State<DashboardPageView> {
  @override
  void initState() {
    super.initState();
    print('🔥 DashboardPageView initState called');
    _loadDashboardData();
  }

  void _loadDashboardData() {
    print('🔥 _loadDashboardData called');
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        print('🔥 Adding LoadDashboardDataEvent');
        context.read<DashboardViewModel>().add(
          LoadDashboardDataEvent(context: context),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('🔥 DashboardPageView build called');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboardData,
          ),
        ],
      ),
      body: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          print('🔥 BlocBuilder called - isLoading: ${state.isLoading}, collections: ${state.collections.length}, products: ${state.products.length}, creators: ${state.creators.length}');
          
          if (state.isLoading) {
            print('🔥 Showing loading indicator');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading dashboard data...'),
                ],
              ),
            );
          }

          // Show message if no data is available
          if (state.collections.isEmpty && 
              state.products.isEmpty && 
              state.creators.isEmpty) {
            print('🔥 Showing no data message');
            return RefreshIndicator(
              onRefresh: () async {
                _loadDashboardData();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 200),
                  const Center(
                    child: Column(
                      children: [
                        Icon(Icons.dashboard, size: 60, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "No data available",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Pull down to refresh or tap refresh button",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  // Debug info even when no data
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Debug Info:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Collections: ${state.collections.length}"),
                        Text("Products: ${state.products.length}"),
                        Text("Creators: ${state.creators.length}"),
                        Text("Loading: ${state.isLoading}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          print('🔥 Showing data');
          return RefreshIndicator(
            onRefresh: () async {
              _loadDashboardData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Always show debug info at the top
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Debug Info:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Collections: ${state.collections.length}"),
                        Text("Products: ${state.products.length}"),
                        Text("Creators: ${state.creators.length}"),
                        Text("Loading: ${state.isLoading}"),
                      ],
                    ),
                  ),
                  
                  if (state.collections.isNotEmpty) ...[
                    const Text(
                      "Collections", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 8),
                    ...state.collections.map((c) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Text(c.title),
                    )).toList(),
                    const SizedBox(height: 20),
                  ],

                  if (state.products.isNotEmpty) ...[
                    const Text(
                      "Products", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 8),
                    ...state.products.map((p) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[200]!),
                      ),
                      child: Text(p.name),
                    )).toList(),
                    const SizedBox(height: 20),
                  ],

                  if (state.creators.isNotEmpty) ...[
                    const Text(
                      "Creators", 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    const SizedBox(height: 8),
                    ...state.creators.map((cr) => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Text(cr.fullName),
                    )).toList(),
                  ],
                  
                  // Fallback content if somehow no sections are shown
                  if (state.collections.isEmpty && state.products.isEmpty && state.creators.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "This shouldn't show if debug info shows data",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Alternative version if the above doesn't work - use this as a separate test file
class DashboardTestView extends StatelessWidget {
  const DashboardTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Test"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 60, color: Colors.green),
            SizedBox(height: 16),
            Text(
              "If you can see this, the widget is rendering correctly",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "The issue is with the BlocBuilder not updating",
              style: TextStyle(fontSize: 14, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_event.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/dashboard_state.dart';

class DashboardPageView extends StatelessWidget {
  const DashboardPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: BlocBuilder<DashboardViewModel, DashboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardViewModel>().add(
                    LoadDashboardDataEvent(context: context),
                  );
            },
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text("Collections", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...state.collections.map((c) => Text(c.title)).toList(),

                const SizedBox(height: 20),
                const Text("Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...state.products.map((p) => Text(p.name)).toList(),

                const SizedBox(height: 20),
                const Text("Creators", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...state.creators.map((cr) => Text(cr.fullName)).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

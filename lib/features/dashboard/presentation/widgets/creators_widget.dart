// widgets/creators_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/dashboard/domain/entity/creator_entity.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_view_model.dart';
import 'package:batch34_b/features/dashboard/presentation/view_model/dashboard_state.dart';

class CreatorsWidget extends StatelessWidget {
  const CreatorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardViewModel, DashboardState>(
      buildWhen: (previous, current) => 
          previous.creators != current.creators || 
          previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const _CreatorsLoading();
        }

        if (state.creators.isEmpty) {
          return const _CreatorsEmpty();
        }

        return _CreatorsList(creators: state.creators);
      },
    );
  }
}

class _CreatorsLoading extends StatelessWidget {
  const _CreatorsLoading();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Creators",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text("Loading creators..."),
          ],
        ),
      ),
    );
  }
}

class _CreatorsEmpty extends StatelessWidget {
  const _CreatorsEmpty();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Creators",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Icon(Icons.people, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              "No creators available",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreatorsList extends StatelessWidget {
  final List<CreatorEntity> creators;

  const _CreatorsList({required this.creators});

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
                  "Creators",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${creators.length}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...creators.map((creator) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.purple[600], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      creator.fullName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
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
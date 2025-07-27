import 'package:flutter/material.dart';

@immutable
sealed class DashboardEvent {}

class LoadDashboardDataEvent extends DashboardEvent {
  final BuildContext context;

  LoadDashboardDataEvent({required this.context});
}

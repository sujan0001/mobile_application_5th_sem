// dashboard_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  
  @override
  List<Object?> get props => [];
}

class LoadDashboardDataEvent extends DashboardEvent {
  final BuildContext context;
  
  const LoadDashboardDataEvent({required this.context});
  
  @override
  List<Object?> get props => [context];
}

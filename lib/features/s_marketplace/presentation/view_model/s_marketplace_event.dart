import 'package:flutter/material.dart';

@immutable
sealed class SMarketplaceEvent {}

class LoadSoldProductsEvent extends SMarketplaceEvent {}

class RefreshSoldProductsEvent extends SMarketplaceEvent {}

class NavigateToProductDetailsEvent extends SMarketplaceEvent {
  final BuildContext context;
  final String productId;

  NavigateToProductDetailsEvent({
    required this.context,
    required this.productId,
  });
}

// Example: Additional events you might need
/*
class BuyProductEvent extends SMarketplaceEvent {
  final BuildContext context;
  final String productId;

  BuyProductEvent({
    required this.context,
    required this.productId,
  });
}

class SearchProductsEvent extends SMarketplaceEvent {
  final String query;

  SearchProductsEvent({required this.query});
}

class FilterProductsEvent extends SMarketplaceEvent {
  final double? minPrice;
  final double? maxPrice;
  final String? category;

  FilterProductsEvent({
    this.minPrice,
    this.maxPrice,
    this.category,
  });
}
*/
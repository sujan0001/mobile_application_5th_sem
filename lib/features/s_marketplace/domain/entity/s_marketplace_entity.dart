import 'package:equatable/equatable.dart';

// Main Product Entity
class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String? description; // Nullable
  final String image;
  final double originalPrice;
  final double? resalePrice; // Nullable
  final UserEntity creator;
  final String collection;
  final UserEntity? owner; // Nullable
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final PendingTransferEntity pendingTransfer;
  final List<SoldHistoryEntity> soldHistory;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.originalPrice,
    this.resalePrice,
    required this.creator,
    required this.collection,
    this.owner,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.pendingTransfer,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        originalPrice,
        resalePrice,
        creator,
        collection,
        owner,
        onSale,
        certified,
        isDeleted,
        pendingTransfer,
        soldHistory,
        createdAt,
        updatedAt,
      ];
}

// User Entity (for creator and owner)
class UserEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        password,
        role,
        isDeleted,
        createdAt,
        updatedAt,
      ];
}

// Pending Transfer Entity
class PendingTransferEntity extends Equatable {
  final bool isPending;
  final String? buyer; // Nullable - can be null

  const PendingTransferEntity({
    required this.isPending,
    this.buyer,
  });

  @override
  List<Object?> get props => [isPending, buyer];
}

// Sold History Entity
class SoldHistoryEntity extends Equatable {
  final String id;
  final String owner;
  final double price;
  final DateTime date;

  const SoldHistoryEntity({
    required this.id,
    required this.owner,
    required this.price,
    required this.date,
  });

  @override
  List<Object?> get props => [id, owner, price, date];
}

// API Response Entity (wrapper for the entire response)
class SoldProductsResponseEntity extends Equatable {
  final bool success;
  final List<ProductEntity> data;

  const SoldProductsResponseEntity({
    required this.success,
    required this.data,
  });

  @override
  List<Object?> get props => [success, data];
}
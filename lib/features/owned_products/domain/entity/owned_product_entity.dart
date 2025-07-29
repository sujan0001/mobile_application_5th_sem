import 'package:equatable/equatable.dart';

class OwnedProductEntity extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String image;
  final int originalPrice;
  final int? resalePrice;
  final bool onSale;
  final bool certified;
  final CreatorEntity creator;
  final CollectionEntity collection;
  final PendingTransferEntity pendingTransfer;
  final String? owner;
  final List<SoldHistoryEntity> soldHistory;
  final String createdAt;
  final String updatedAt;

  const OwnedProductEntity({
    required this.id,
    required this.name,
    this.description,
    required this.image,
    required this.originalPrice,
    this.resalePrice,
    required this.onSale,
    required this.certified,
    required this.creator,
    required this.collection,
    required this.pendingTransfer,
    this.owner,
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
        onSale,
        certified,
        creator,
        collection,
        pendingTransfer,
        owner,
        soldHistory,
        createdAt,
        updatedAt,
      ];
}

class CreatorEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const CreatorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, email, role, isDeleted, createdAt, updatedAt];
}

class CollectionEntity extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String? coverImage;
  final String creator;
  final bool certified;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const CollectionEntity({
    required this.id,
    required this.title,
    this.description,
    this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, title, description, coverImage, creator, certified, isDeleted, createdAt, updatedAt];
}

class PendingTransferEntity extends Equatable {
  final bool isPending;
  final String? buyer;

  const PendingTransferEntity({
    required this.isPending,
    this.buyer,
  });

  @override
  List<Object?> get props => [isPending, buyer];
}

class SoldHistoryEntity extends Equatable {
  final String id;
  final String owner;
  final int price;
  final String date;

  const SoldHistoryEntity({
    required this.id,
    required this.owner,
    required this.price,
    required this.date,
  });

  @override
  List<Object?> get props => [id, owner, price, date];
}
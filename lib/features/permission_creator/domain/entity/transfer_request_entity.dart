import 'package:equatable/equatable.dart';

class TransferRequestEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final int originalPrice;
  final String creator;
  final CollectionEntity? collection;
  final PendingTransferEntity pendingTransfer;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final List<SoldHistoryEntity> soldHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String? owner;
  final int? resalePrice;

  const TransferRequestEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.creator,
    required this.collection,
    required this.pendingTransfer,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.owner,
    this.resalePrice,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        image,
        originalPrice,
        creator,
        collection,
        pendingTransfer,
        onSale,
        certified,
        isDeleted,
        soldHistory,
        createdAt,
        updatedAt,
        version,
        owner,
        resalePrice,
      ];
}

class CollectionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final String creator;
  final bool certified;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  const CollectionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.creator,
    required this.certified,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImage,
        creator,
        certified,
        isDeleted,
        createdAt,
        updatedAt,
        version,
      ];
}

class PendingTransferEntity extends Equatable {
  final bool isPending;
  final BuyerEntity buyer;

  const PendingTransferEntity({
    required this.isPending,
    required this.buyer,
  });

  @override
  List<Object?> get props => [isPending, buyer];
}

class BuyerEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  const BuyerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
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
        version,
      ];
}

class SoldHistoryEntity extends Equatable {
  final String id;
  final String owner;
  final int price;
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

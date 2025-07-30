class ProductDetailEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final double originalPrice;
  final CreatorEntity creator;
  final CollectionEntity collection;
  final bool onSale;
  final bool certified;
  final bool isDeleted;
  final List<SoldHistoryEntity> soldHistory;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OwnerEntity? owner;
  final double? resalePrice;
  final PendingTransferEntity pendingTransfer;

  const ProductDetailEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.originalPrice,
    required this.creator,
    required this.collection,
    required this.onSale,
    required this.certified,
    required this.isDeleted,
    required this.soldHistory,
    required this.createdAt,
    required this.updatedAt,
    this.owner,
    this.resalePrice,
    required this.pendingTransfer,
  });
}

class CreatorEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

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
}

class CollectionEntity {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final String creator;
  final bool certified;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

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
  });
}

class OwnerEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OwnerEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });
}

class SoldHistoryEntity {
  final String owner;
  final double price;
  final String id;
  final DateTime date;

  const SoldHistoryEntity({
    required this.owner,
    required this.price,
    required this.id,
    required this.date,
  });
}

class PendingTransferEntity {
  final bool isPending;
  final String? buyer;

  const PendingTransferEntity({
    required this.isPending,
    this.buyer,
  });
}

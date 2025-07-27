class CreatorEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;

  const CreatorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });
   String get fullName => '$firstName $lastName';
}

class ServiceTypeEntity {
  final int id;
  final String serviceTypeName;
  final String description;
  final String createdAt;
  final String updatedAt;

  ServiceTypeEntity({
    required this.id,
    required this.serviceTypeName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'ServiceTypeEntity(id: $id, serviceTypeName: $serviceTypeName, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

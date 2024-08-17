class HomeExaminationPackageEntity {
  final int id;
  final String serviceName;
  final String priceTag;
  final String description;
  final String duration;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  HomeExaminationPackageEntity({
    required this.id,
    required this.serviceName,
    required this.priceTag,
    required this.description,
    required this.duration,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'HomeExaminationPackageEntity: $id, $serviceName, $priceTag, $description, $duration, $filePath, $createdAt, $updatedAt';
  }
}

class TypeCreateAppointmentServiceEntity {
  final int? id;
  final String? serviceName;
  final String? priceTag;
  final String? description;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;

  TypeCreateAppointmentServiceEntity({
    this.id = -1,
    this.serviceName = '',
    this.priceTag = '',
    this.description = '',
    this.duration = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  // Factory constructor to provide default values
  factory TypeCreateAppointmentServiceEntity.withDefaults({
    int id = -1,
    String serviceName = '',
    String priceTag = '',
    String description = '',
    String? duration = '',
    String? createdAt = '',
    String? updatedAt = '',
  }) {
    return TypeCreateAppointmentServiceEntity(
      id: id,
      serviceName: serviceName,
      priceTag: priceTag,
      description: description,
      duration: duration,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  String toString() {
    return 'TypeCreateAppointmentServiceEntity(id: $id, serviceName: $serviceName, priceTag: $priceTag, description: $description, duration: $duration, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

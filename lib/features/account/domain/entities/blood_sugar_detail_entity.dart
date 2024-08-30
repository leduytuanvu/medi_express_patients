class BloodSugarDetailEntity {
  int id;
  int patientId;
  String bloodSugarAfterMeal;
  String bloodSugarBeforeMeal;
  String createdAt;
  String updatedAt;

  BloodSugarDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.bloodSugarAfterMeal = '',
    this.bloodSugarBeforeMeal = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'BloodSugarDetailEntity(id: $id, patientId: $patientId, dystolicBloodPressure: $bloodSugarAfterMeal, $bloodSugarBeforeMeal, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

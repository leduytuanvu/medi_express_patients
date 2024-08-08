class DoctorInformationDetailEntity {
  final int doctorId;
  final String doctorName;
  final String? doctorAvatar;
  final InformationEntity information;
  final List<WorkingProcessEntity> workingProcess;

  DoctorInformationDetailEntity({
    this.doctorId = -1,
    this.doctorName = '',
    this.doctorAvatar,
    required this.information,
    required this.workingProcess,
  });
}

class InformationEntity {
  final int id;
  final int doctorId;
  final String degree;
  final String major;
  final String specialistDoctor;
  final String currentWork;

  InformationEntity({
    this.id = -1,
    this.doctorId = -1,
    this.degree = '',
    this.major = '',
    this.specialistDoctor = '',
    this.currentWork = '',
  });
}

class WorkingProcessEntity {
  final int id;
  final int doctorId;
  final String year;
  final String info;

  WorkingProcessEntity({
    this.id = -1,
    this.doctorId = -1,
    this.year = '',
    this.info = '',
  });
}

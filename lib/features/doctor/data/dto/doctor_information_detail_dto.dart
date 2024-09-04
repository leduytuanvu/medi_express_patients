import 'package:medi_express_patients/features/doctor/domain/entities/doctor_information_detail_entity.dart';

class DoctorInformationDetailDto {
  final int doctorId;
  final String doctorName;
  final String? doctorAvatar;
  final String? doctorActive;
  final String? major;
  final String? degree;
  final String? workingPlace;
  final String? specialistDoctor;

  // final InformationDto information;
  // final List<WorkingProcessDto> workingProcess;

  DoctorInformationDetailDto({
    required this.doctorId,
    required this.doctorName,
    this.doctorAvatar,
    required this.doctorActive,
    this.major,
    this.degree,
    this.workingPlace,
    this.specialistDoctor,
    // required this.information,
    // required this.workingProcess,
  });

  factory DoctorInformationDetailDto.fromJson(Map<String, dynamic> json) {
    return DoctorInformationDetailDto(
      doctorId: json['doctorId'] ?? -1,
      doctorName: json['doctorName'] ?? '',
      doctorAvatar: json['doctorAvatar'] ?? '',
      doctorActive: json['doctorActive'] ?? '',
      major: json['Major'] ?? '',
      degree: json['Degree'] ?? '',
      workingPlace: json['WorkingPlace'] ?? '',
      specialistDoctor: json['SpecialistDoctor'] ?? '',
      // information: InformationDto.fromJson(json['Information']),
      // workingProcess: (json['WorkingProcess'] as List)
      //     .map((item) => WorkingProcessDto.fromJson(item))
      //     .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId ?? -1,
      'doctorName': doctorName ?? '',
      'doctorAvatar': doctorAvatar ?? '',
      'doctorActive': doctorActive ?? '',
      'Major': major ?? '',
      'Degree': degree ?? '',
      'WorkingPlace': workingPlace ?? '',
      'SpecialistDoctor': specialistDoctor ?? '',
      // 'Information': information.toJson(),
      // 'WorkingProcess': workingProcess.map((item) => item.toJson()).toList(),
    };
  }

  DoctorInformationDetailEntity toEntity() {
    return DoctorInformationDetailEntity(
      doctorId: doctorId ?? -1,
      doctorName: doctorName ?? '',
      doctorAvatar: doctorAvatar ?? '',
      doctorActive: doctorActive ?? '',
      major: major ?? '',
      degree: degree ?? '',
      workingPlace: workingPlace ?? '',
      specialistDoctor: specialistDoctor ?? '',
      // docto: doctorAvatar,
      // doctorAvatar: doctorAvatar,
      // doctorAvatar: doctorAvatar,
      // doctorAvatar: doctorAvatar,
      // doctorAvatar: doctorAvatar,
      // information: information.toEntity(),
      // workingProcess: workingProcess.map((item) => item.toEntity()).toList(),
    );
  }
}

// class InformationDto {
//   final int id;
//   final int doctorId;
//   final String? degree;
//   final String? major;
//   final String? specialistDoctor;
//   final String? currentWork;
//
//   InformationDto({
//     required this.id,
//     required this.doctorId,
//     required this.degree,
//     required this.major,
//     required this.specialistDoctor,
//     required this.currentWork,
//   });
//
//   factory InformationDto.fromJson(Map<String, dynamic> json) {
//     return InformationDto(
//       id: json['id'],
//       doctorId: json['DoctorID'],
//       degree: json['Degree'] ?? '',
//       major: json['Major'] ?? '',
//       specialistDoctor: json['SpecialistDoctor'] ?? '',
//       currentWork: json['CurrentWork'] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'DoctorID': doctorId,
//       'Degree': degree,
//       'Major': major,
//       'SpecialistDoctor': specialistDoctor,
//       'CurrentWork': currentWork,
//     };
//   }
//
//   InformationEntity toEntity() {
//     return InformationEntity(
//       id: id,
//       doctorId: doctorId,
//       degree: degree ?? '',
//       major: major ?? '',
//       specialistDoctor: specialistDoctor ?? '',
//       currentWork: currentWork ?? '',
//     );
//   }
// }
//
// class WorkingProcessDto {
//   final int id;
//   final int doctorId;
//   final String year;
//   final String info;
//
//   WorkingProcessDto({
//     required this.id,
//     required this.doctorId,
//     required this.year,
//     required this.info,
//   });
//
//   factory WorkingProcessDto.fromJson(Map<String, dynamic> json) {
//     return WorkingProcessDto(
//       id: json['id'],
//       doctorId: json['DoctorID'],
//       year: json['Year'],
//       info: json['Infor'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'DoctorID': doctorId,
//       'Year': year,
//       'Infor': info,
//     };
//   }
//
//   WorkingProcessEntity toEntity() {
//     return WorkingProcessEntity(
//       id: id,
//       doctorId: doctorId,
//       year: year,
//       info: info,
//     );
//   }
// }

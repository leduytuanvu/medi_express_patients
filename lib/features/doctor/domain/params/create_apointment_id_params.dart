import 'package:equatable/equatable.dart';

class CreateAppointmentIdParams extends Equatable {
  final int doctorId;
  final int patientID;
  final int serviceID;
  final int serviceTypeID;
  final String appointmentDate;
  final String startTime;
  final String endTime;

  const CreateAppointmentIdParams({
    required this.doctorId,
    required this.patientID,
    required this.serviceID,
    required this.serviceTypeID,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [
        doctorId,
        patientID,
        serviceID,
        serviceTypeID,
        appointmentDate,
        startTime,
        endTime
      ];
}

import 'package:equatable/equatable.dart';

class CreateAppointmentParams extends Equatable {
  final int patientID;
  final int serviceID;
  final int serviceTypeID;
  final String appointmentDate;
  final String startTime;
  final String endTime;

  const CreateAppointmentParams({
    required this.patientID,
    required this.serviceID,
    required this.serviceTypeID,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [
        patientID,
        serviceID,
        serviceTypeID,
        appointmentDate,
        startTime,
        endTime
      ];
}

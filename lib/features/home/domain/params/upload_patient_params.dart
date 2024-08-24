import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadPatientParams extends Equatable {
  final File file;
  final String nameHealthRecord;
  final String description;
  final String createDate;

  const UploadPatientParams({
    required this.file,
    required this.nameHealthRecord,
    required this.description,
    required this.createDate,
  });

  @override
  List<Object?> get props => [
        file,
        nameHealthRecord,
        description,
        createDate,
      ];
}

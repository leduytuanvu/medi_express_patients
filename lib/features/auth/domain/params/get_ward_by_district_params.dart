import 'package:equatable/equatable.dart';

class GetWardByDistrictParams extends Equatable {
  final int districtId;

  const GetWardByDistrictParams({
    required this.districtId,
  });

  @override
  List<Object?> get props => [districtId];
}

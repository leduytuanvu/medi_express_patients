import 'package:equatable/equatable.dart';

class GetDistrictByCityParams extends Equatable {
  final int cityId;

  const GetDistrictByCityParams({required this.cityId});

  @override
  List<Object?> get props => [cityId];
}

import 'package:equatable/equatable.dart';

class GetListHealthIndexParams extends Equatable {
  final String start;
  final String end;
  final String offset;
  final String limit;

  const GetListHealthIndexParams({
    required this.start,
    required this.end,
    required this.offset,
    required this.limit,
  });

  @override
  List<Object?> get props => [
        start,
        end,
        offset,
        limit,
      ];
}

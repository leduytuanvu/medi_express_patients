import 'package:equatable/equatable.dart';

class CreateConversationParams extends Equatable {
  final int participantOneID;
  final int participantTwoID;

  const CreateConversationParams({
    required this.participantOneID,
    required this.participantTwoID,
  });

  @override
  List<Object?> get props => [
        participantOneID,
        participantTwoID,
      ];
}

import 'package:medi_express_patients/features/chat/domain/entities/create_conversation_entity.dart';

class CreateConversationDto {
  final int conversationID;
  final int participantOneID;
  final int participantTwoID;
  final String updatedAt;
  final String createdAt;

  CreateConversationDto({
    required this.conversationID,
    required this.participantOneID,
    required this.participantTwoID,
    required this.updatedAt,
    required this.createdAt,
  });

  factory CreateConversationDto.fromJson(Map<String, dynamic> json) {
    return CreateConversationDto(
      conversationID: json['ConversationID'],
      participantOneID: json['ParticipantOneID'],
      participantTwoID: json['ParticipantTwoID'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ConversationID': conversationID,
      'ParticipantOneID': participantOneID,
      'ParticipantTwoID': participantTwoID,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  CreateConversationEntity toEntity() {
    return CreateConversationEntity(
      conversationID: conversationID,
      participantOneID: participantOneID,
      participantTwoID: participantTwoID,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}

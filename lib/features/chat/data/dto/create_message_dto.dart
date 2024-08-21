import 'package:medi_express_patients/features/chat/domain/entities/create_message_entity.dart';

class CreateMessageDto {
  final int id;
  final int conversationID;
  final int senderID;
  final String messageText;
  final String updatedAt;
  final String createdAt;

  CreateMessageDto({
    required this.id,
    required this.conversationID,
    required this.senderID,
    required this.messageText,
    required this.updatedAt,
    required this.createdAt,
  });

  factory CreateMessageDto.fromJson(Map<String, dynamic> json) {
    return CreateMessageDto(
      id: json['id'],
      conversationID: json['ConversationID'],
      senderID: json['SenderID'],
      messageText: json['MessageText'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ConversationID': conversationID,
      'SenderID': senderID,
      'MessageText': messageText,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  CreateMessageEntity toEntity() {
    return CreateMessageEntity(
      id: id,
      conversationID: conversationID,
      senderID: senderID,
      messageText: messageText,
      updatedAt: updatedAt,
      createdAt: createdAt,
    );
  }
}

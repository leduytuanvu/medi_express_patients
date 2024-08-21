import 'package:medi_express_patients/features/chat/domain/entities/message_entity.dart';

class MessageDto {
  final int id;
  final int conversationID;
  final int senderID;
  final String messageText;
  final String createdAt;
  final String updatedAt;

  MessageDto({
    required this.id,
    required this.conversationID,
    required this.senderID,
    required this.messageText,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageDto.fromJson(Map<String, dynamic> json) {
    return MessageDto(
      id: json['id'],
      conversationID: json['ConversationID'],
      senderID: json['SenderID'],
      messageText: json['MessageText'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ConversationID': conversationID,
      'SenderID': senderID,
      'MessageText': messageText,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      conversationID: conversationID,
      senderID: senderID,
      messageText: messageText,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

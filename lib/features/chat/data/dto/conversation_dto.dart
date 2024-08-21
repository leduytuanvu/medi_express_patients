import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';

class ConversationDto {
  final int conversationID;
  final int idUser;
  final String? avatar;
  final String name;
  final String role;
  final String? lastMessage;
  final String? lastMessageTime;

  ConversationDto({
    required this.conversationID,
    required this.idUser,
    this.avatar,
    required this.name,
    required this.role,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory ConversationDto.fromJson(Map<String, dynamic> json) {
    return ConversationDto(
      conversationID: json['conversationID'],
      idUser: json['idUser'],
      avatar: json['avatar'] ?? '',
      name: json['name'],
      role: json['role'],
      lastMessage: json['lastMessage'] ?? '',
      lastMessageTime: json['lastMessageTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationID': conversationID,
      'idUser': idUser,
      'avatar': avatar ?? '',
      'name': name,
      'role': role,
      'lastMessage': lastMessage ?? '',
      'lastMessageTime': lastMessageTime ?? '',
    };
  }

  ConversationEntity toEntity() {
    return ConversationEntity(
      conversationID: conversationID,
      idUser: idUser,
      avatar: avatar ?? '',
      name: name,
      role: role,
      lastMessage: lastMessage ?? '',
      lastMessageTime: lastMessageTime ?? '',
    );
  }
}

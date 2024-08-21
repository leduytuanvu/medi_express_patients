class ConversationEntity {
  final int conversationID;
  final int idUser;
  final String? avatar;
  final String name;
  final String role;
  final String? lastMessage;
  final String? lastMessageTime;

  ConversationEntity({
    required this.conversationID,
    required this.idUser,
    this.avatar,
    required this.name,
    required this.role,
    this.lastMessage,
    this.lastMessageTime,
  });

  @override
  String toString() {
    return 'ConversationEntity(conversationID: $conversationID, idUser: $idUser, avatar: $avatar, name: $name, role: $role, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime)';
  }
}

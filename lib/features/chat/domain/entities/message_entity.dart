class MessageEntity {
  final int id;
  final int conversationID;
  final int senderID;
  final String messageText;
  final String createdAt;
  final String updatedAt;

  MessageEntity({
    required this.id,
    required this.conversationID,
    required this.senderID,
    required this.messageText,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'MessageEntity(id: $id, conversationID: $conversationID, senderID: $senderID, messageText: $messageText, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

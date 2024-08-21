class CreateMessageEntity {
  final int id;
  final int conversationID;
  final int senderID;
  final String messageText;
  final String updatedAt;
  final String createdAt;

  CreateMessageEntity({
    required this.id,
    required this.conversationID,
    required this.senderID,
    required this.messageText,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'CreateMessageEntity(id: $id, conversationID: $conversationID, senderID: $senderID, messageText: $messageText, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}

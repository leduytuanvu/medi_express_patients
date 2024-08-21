class CreateConversationEntity {
  final int conversationID;
  final int participantOneID;
  final int participantTwoID;
  final String updatedAt;
  final String createdAt;

  CreateConversationEntity({
    required this.conversationID,
    required this.participantOneID,
    required this.participantTwoID,
    required this.updatedAt,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'CreateConversationEntity(conversationID: $conversationID, participantOneID: $participantOneID, participantTwoID: $participantTwoID, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}

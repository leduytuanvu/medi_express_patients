import 'package:equatable/equatable.dart';

class CreateMessageParams extends Equatable {
  final int conversationID;
  final int senderID;
  final String messageText;

  const CreateMessageParams({
    required this.conversationID,
    required this.senderID,
    required this.messageText,
  });

  @override
  List<Object?> get props => [
        conversationID,
        senderID,
        messageText,
      ];
}

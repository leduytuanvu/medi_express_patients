import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medi_express_patients/features/chat/data/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final class WebSocketManager {
  //I want init one time connection so I using singleton pattern
  static final WebSocketManager instance = WebSocketManager();

  String _fetchBaseUrl() {
    switch (kDebugMode) {
      case true:
        return "http://localhost:3000";
      default:
        //Product host url
        return "";
    }
  }

  //Our socket object
  IO.Socket get socket => IO.io(
      _fetchBaseUrl(), IO.OptionBuilder().setTransports(['websocket']).build());

  initializeSocketConnection() {
    try {
      socket.connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success");
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  disconnectFromSocket() {
    socket.disconnect();
    socket.onDisconnect((data) => debugPrint("Websocket disconnected"));
  }

  //Getting data from subscribed messages and calling onEvent callback
  void webSocketReceiver(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  //Sending data to any channel
  void webSocketSender(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }
}

mixin class ChatViewManager {
  List<MessageModel> messages = [];
  final TextEditingController msgController = TextEditingController();

  listenMessageEvent(VoidCallback setState) {
    WebSocketManager.instance.webSocketReceiver("chat_update", (data) {
      messages.add(MessageModel.fromJson(data));
      setState();
    });
  }

  sendMessage(String sender, VoidCallback setState) {
    final MessageModel data =
        MessageModel(sender: sender, msg: msgController.text);
    WebSocketManager.instance.webSocketSender("chat_update", data.toJson());
    //Reset input
    msgController.text = "";
    setState();
  }

  Alignment setMessageAlignment(String senderName, String userName) {
    switch (senderName == userName) {
      case true:
        return Alignment.topRight;
      case false:
        return Alignment.topLeft;
    }
  }
}

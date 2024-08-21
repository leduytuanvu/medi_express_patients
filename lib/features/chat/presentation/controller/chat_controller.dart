import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_conversation_params.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_message_params.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_message_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_message_usecase.dart';
import 'package:medi_express_patients/features/chat/presentation/state/chat_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends BaseController {
  final GetAllMessageUsecase getAllMessageUsecase;
  final GetAllConversationUsecase getAllConversationUsecase;
  final CreateConversationUsecase createConversationUsecase;
  final CreateMessageUsecase createMessageUsecase;
  ChatController({
    required this.getAllMessageUsecase,
    required this.getAllConversationUsecase,
    required this.createConversationUsecase,
    required this.createMessageUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final ChatState chatState = ChatState();

  final searchController = TextEditingController();

  IO.Socket? socket;

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    // connectSocket();
  }

  // void connectSocket() {
  //   socket = IO.io(
  //       'http://api-stg.combros.tech:10110?token=${authController.baseState.auth.value.accessToken}',
  //       IO.OptionBuilder()
  //           .setTransports(['websocket']) // Enable WebSocket transport
  //           .disableAutoConnect() // Disable auto-connect
  //           // .setAuth({'token': authController.baseState.auth.value.accessToken})
  //           .build());
  //
  //   // Connect to the socket server
  //   socket?.connect();
  //
  //   // Listen for connection success
  //   socket?.onConnect((_) {
  //     Log.info('Connected to the server');
  //   });
  //
  //   // Listen for connection errors
  //   socket?.onConnectError((error) {
  //     Log.info('Connection error: $error');
  //   });
  //
  //   // Listen for disconnection
  //   socket?.onDisconnect((_) {
  //     Log.info('Disconnected from the server');
  //   });
  //
  //   // Listen for incoming messages
  //   socket?.on('message', (data) {
  //     Log.info("|||||||||||||||||||||||||||||||||||||| message ${data}");
  //     chatState.messages.add(data); // Add the incoming message to the list
  //   });
  //
  //   // Listen for incoming messages
  //   socket?.on('newMessage', (data) {
  //     Log.info("|||||||||||||||||||||||||||||||||||||| new message ${data}");
  //     chatState.messages.add(data); // Add the incoming message to the list
  //   });
  //
  //   // Listen for incoming messages
  //   socket?.on('sendMessage', (data) {
  //     Log.info("|||||||||||||||||||||||||||||||||||||| send message ${data}");
  //     chatState.messages.add(data); // Add the incoming message to the list
  //   });
  //
  //   // Listen for incoming messages
  //   socket?.on('ping', (data) {
  //     Log.info("|||||||||||||||||||||||||||||||||||||| ping ${data}");
  //     chatState.messages.add(data); // Add the incoming message to the list
  //   });
  // }

  // void connectSocket() {
  //   socket = IO.io(
  //     'http://api-stg.combros.tech:10110?token=${authController.baseState.auth.value.accessToken}',
  //     IO.OptionBuilder()
  //         .setTransports(['websocket']) // Enable WebSocket transport
  //         .enableReconnection() // Enable automatic reconnection
  //         .disableAutoConnect() // Disable auto-connect
  //         .build(),
  //   );
  //
  //   socket?.connect();
  //
  //   socket?.onConnect((_) {
  //     Log.info(
  //         '|||||||||||||||||||||||||||||||||||||| Connected to the server');
  //   });
  //
  //   socket?.on('connect_error', (error) {
  //     Log.info(
  //         '|||||||||||||||||||||||||||||||||||||| Connection error: $error');
  //     // Add additional error handling logic here if needed
  //   });
  //
  //   socket?.onDisconnect((_) {
  //     Log.info(
  //         '|||||||||||||||||||||||||||||||||||||| Disconnected from the server');
  //   });
  //
  //   // socket?.on('message', (data) {
  //   //   Log.info(
  //   //       "|||||||||||||||||||||||||||||||||||||| Received message: $data");
  //   //   chatState.messages.add(data);
  //   // });
  //
  //   socket?.on('newMessage', (data) {
  //     Log.info(
  //         "|||||||||||||||||||||||||||||||||||||| Received new message: $data");
  //     chatState.messages.add(data);
  //   });
  //
  //   // socket?.on('sendMessage', (data) {
  //   //   Log.info("|||||||||||||||||||||||||||||||||||||| Message sent: $data");
  //   //   chatState.messages.add(data);
  //   // });
  //   //
  //   // socket?.on('ping', (data) {
  //   //   Log.info("|||||||||||||||||||||||||||||||||||||| Ping received: $data");
  //   //   chatState.messages.add(data);
  //   // });
  //   //
  //   // socket?.on('receiveMessage', (data) {
  //   //   Log.info("|||||||||||||||||||||||||||||||||||||| Ping received: $data");
  //   //   chatState.messages.add(data);
  //   // });
  // }

  void connectSocket() {
    socket = IO.io(
      'http://api-stg.combros.tech:10110?token=${authController.baseState.auth.value.accessToken}',
      IO.OptionBuilder()
          .setTransports(['websocket']) // Enable WebSocket transport
          .enableReconnection() // Enable automatic reconnection
          .disableAutoConnect() // Disable auto-connect
          .build(),
    );

    // Connect to the socket server
    socket?.connect();

    // Listen for connection success
    socket?.onConnect((_) {
      Log.info('Connected to the server');
    });

    // Listen for connection errors
    socket?.onConnectError((error) {
      Log.info('Connection error: $error');
    });

    // Listen for disconnection
    socket?.onDisconnect((_) {
      Log.info('Disconnected from the server');
    });

    // Listen for the 'newMessage' event from the server
    socket?.on('newMessage', (data) {
      Log.info("Received new message: $data");
      chatState.messages.add(data); // Add the incoming message to the list
    });

    // Listen for 'receiveMessage' event which might be emitted when a message is sent to a room
    socket?.on('receiveMessage', (data) {
      Log.info("Received message from room: $data");
      chatState.messages.add(data); // Add the incoming message to the list
    });
  }

  // Send a message to the server
  // void sendMessage(String message) {
  //   if (message.isNotEmpty) {
  //     socket?.emit('message', message);
  //     Log.info("|||||||||||||||||||||||||||||||||||||| message ${message}");
  //     chatState.messageTextController.value = ''; // Clear the input field
  //   }
  // }

  void joinRoom(int roomID) {
    socket?.emit('joinRoom', roomID);
    Log.info("Joined room: $roomID");
  }

  void sendMessage(String message, int roomID) {
    if (message.isNotEmpty) {
      socket?.emit('sendMessage', {'roomID': roomID, 'message': message});
      Log.info("Sent message: $message to room $roomID");
      chatState.messageTextController.value = ''; // Clear the input field
    }
  }

  @override
  void onClose() {
    // Disconnect the socket when the controller is closed
    socket?.disconnect();
    super.onClose();
  }

  Future<void> createMessage(ConversationEntity conversation) async {
    authController.showLoading();
    final result = await createMessageUsecase(
      CreateMessageParams(
        conversationID: conversation.conversationID,
        senderID: authController.baseState.user.value.id,
        messageText: searchController.text.trim(),
      ),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        searchController.text = '';
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> createConversation(int doctorId) async {
    authController.showLoading();
    final result = await createConversationUsecase(
      CreateConversationParams(
        participantOneID: authController.baseState.user.value.id,
        participantTwoID: doctorId,
      ),
    );
    result.fold(
      (failure) {
        Log.severe("create conversion fail: $failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("create conversion true: $success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllConversation() async {
    authController.showLoading();
    final result =
        await getAllConversationUsecase(authController.baseState.user.value.id);
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        chatState.listConversation.value = success;
        Log.severe("list conversation 2: ${chatState.listConversation}");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllMessage(ConversationEntity conversation) async {
    authController.showLoading();
    final result = await getAllMessageUsecase(conversation.conversationID);
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("list message: $success");
        chatState.listMessage.value = success;
        authController.clearError();
      },
    );
    authController.hideLoading();
  }
}

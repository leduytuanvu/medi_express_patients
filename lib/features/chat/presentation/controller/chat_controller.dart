import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/chat/data/dto/message_dto.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_conversation_params.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_message_params.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_message_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_message_usecase.dart';
import 'package:medi_express_patients/features/chat/presentation/state/chat_state.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';
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
      Log.info('-------------------------- Connected to the server');
    });

    // Listen for connection errors
    socket?.onConnectError((error) {
      Log.info('-------------------------- Connection error: $error');
    });

    // Listen for disconnection
    socket?.onDisconnect((_) {
      Log.info('-------------------------- Disconnected from the server');
    });

    // Listen for the 'newMessage' event from the server
    socket?.on('newMessage', (data) {
      Log.info("-------------------------- Received new newMessage: $data");
      chatState.messages.add(data); // Add the incoming message to the list
    });

    // Listen for 'receiveMessage' event
    socket?.on('receiveMessage', (data) {
      Log.info("-------------------------- receiveMessage");
      _handleSocketMessage(data);
    });

    // Listen for 'message' event
    socket?.on('message', (data) {
      Log.info("-------------------------- message");
      _handleSocketMessage(data);
    });
  }

  String getCurrentLastMessageDate() {
    DateTime now = DateTime.now().toUtc(); // Get current date and time in UTC
    String formattedDate =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(now);
    return formattedDate;
  }

  void _handleSocketMessage(dynamic data) async {
    try {
      Log.info(
          "-------------------------- Received unexpected data format: $data");
      // Proceed with converting the Map to MessageDto and then to MessageEntity
      MessageDto messageDto = MessageDto.fromJson(data);
      MessageEntity messageEntity = messageDto.toEntity();

      Log.info(
        "-------------------------- messageEntity: ${messageEntity.messageText}",
      );

      // Add the messageEntity to your chatState or other data structures as needed
      // chatState.listMessage.add(messageEntity);
      chatState.listMessage.insert(0, messageEntity);
      final result = await getAllConversationUsecase(
          authController.baseState.user.value.id);
      result.fold(
        (failure) {},
        (success) {
          chatState.listConversation.value = success;
          Log.severe("list conversation 2: ${chatState.listConversation}");
          authController.clearError();
        },
      );
    } catch (e) {
      Log.info("-------------------------- Error handling socket message: $e");
    }
  }

  void joinRoom(int roomID) {
    Log.info("Joined room 1: ${roomID.runtimeType}");
    socket?.emit('joinRoom', roomID.toString());
    Log.info("Joined room 2: $roomID");
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

  Future<void> createMessage(int conversationId) async {
    final result = await createMessageUsecase(
      CreateMessageParams(
        conversationID: conversationId,
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
  }

  Future<void> createConversation(int doctorId, BuildContext context) async {
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
        context.toNamedScreen(AppRoutes.chatDetail,
            arguments: {'conversationId': success.conversationID});
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllConversation(BuildContext context) async {
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
      (success) async {
        chatState.listConversation.value = success;
        Log.severe("list conversation 2: ${chatState.listConversation}");
        final MainController mainController = Get.find<MainController>();
        if (mainController.mainState.doctorInformation.value != null) {
          Log.info("!= nulllllllllllllll");
          var tmpConversation = ConversationEntity(
              conversationID: -1, idUser: -1, name: '', role: '');
          for (var tmpItem in success) {
            if (tmpItem.idUser ==
                mainController.mainState.doctorInformation.value!.doctorId) {
              tmpConversation = tmpItem;
            }
          }
          Log.info(
              "tmpConversation: ${tmpConversation.toString()}, doctorId: ${mainController.mainState.doctorInformation.value!.doctorId}");
          if (tmpConversation.conversationID != -1) {
            context.toNamedScreen(AppRoutes.chatDetail, arguments: {
              'conversationId': tmpConversation.conversationID,
              'avatarDoctor': tmpConversation.avatar,
              'nameDoctor': tmpConversation.name,
            });
          } else {
            final resultCreate = await createConversationUsecase(
              CreateConversationParams(
                participantOneID: authController.baseState.user.value.id,
                participantTwoID:
                    mainController.mainState.doctorInformation.value!.doctorId,
              ),
            );
            resultCreate.fold(
              (failureCreate) {
                Log.severe("create conversion fail: $failureCreate");
                authController.showError(
                  () => authController.clearError(),
                  failureCreate.message,
                  'Quay lại',
                );
              },
              (successCreate) async {
                final resultGetAgain = await getAllConversationUsecase(
                    authController.baseState.user.value.id);
                resultGetAgain.fold((failureGetAgain) {
                  Log.severe("$failureGetAgain");
                  authController.showError(
                    () => authController.clearError(),
                    failureGetAgain.message,
                    'Quay lại',
                  );
                }, (successAgain) async {
                  tmpConversation = ConversationEntity(
                      conversationID: -1, idUser: -1, name: '', role: '');
                  for (var tmpItem in successAgain) {
                    if (tmpItem.idUser ==
                        mainController
                            .mainState.doctorInformation.value!.doctorId) {
                      tmpConversation = tmpItem;
                    }
                  }
                  if (tmpConversation.conversationID != -1) {
                    context.toNamedScreen(AppRoutes.chatDetail, arguments: {
                      'conversationId': tmpConversation.conversationID,
                      'avatarDoctor': tmpConversation.avatar,
                      'nameDoctor': tmpConversation.name,
                    });
                    authController.clearError();
                  } else {
                    authController.showError(
                      () => authController.clearError(),
                      "Không tìm thấy tin nhắn",
                      'Quay lại',
                    );
                  }
                });
                // Log.severe("create conversion true: $success");
                // context.toNamedScreen(AppRoutes.chatDetail, arguments: {
                //   'conversationId': successCreate.conversationID,
                //   'avatarDoctor': successCreate.ava,
                //   'nameDoctor': successCreate.conversationID,
                // });
                // authController.clearError();
              },
            );
          }
        } else {
          Log.info("nulllllllllllllll");
        }
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getAllMessage(int conversationId) async {
    authController.showLoading();
    final result = await getAllMessageUsecase(conversationId);
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

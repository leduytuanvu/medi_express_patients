import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_message_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_message_usecase.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => ChatController(
          getAllConversationUsecase: Get.find<GetAllConversationUsecase>(),
          getAllMessageUsecase: Get.find<GetAllMessageUsecase>(),
          createMessageUsecase: Get.find<CreateMessageUsecase>(),
          createConversationUsecase: Get.find<CreateConversationUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}

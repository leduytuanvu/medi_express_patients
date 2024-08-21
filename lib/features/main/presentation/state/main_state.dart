import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';

class MainState extends BaseState {
  var currentIndex = 0.obs;

  var messages = <String>[].obs;
  var messageTextController = ''.obs;
}

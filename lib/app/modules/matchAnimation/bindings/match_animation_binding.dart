import 'package:get/get.dart';

import '../controllers/match_animation_controller.dart';

class MatchAnimationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MatchAnimationController>(
      () => MatchAnimationController(),
    );
  }
}

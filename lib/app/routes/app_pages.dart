import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/matchAnimation/bindings/match_animation_binding.dart';
import '../modules/matchAnimation/views/match_animation_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MATCH_ANIMATION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MATCH_ANIMATION,
      page: () => const MatchAnimationView(),
      binding: MatchAnimationBinding(),
    ),
  ];
}

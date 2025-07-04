import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class MatchAnimationController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController cardAnimationController;
  late AnimationController fireworksController;
  late AnimationController textController;

  late Animation<double> card1XAnimation;
  late Animation<double> card2XAnimation;
  late Animation<double> card2YAnimation;
  late Animation<double> card1RotationAnimation;
  late Animation<double> card2RotationAnimation;
  late Animation<double> fireworksAnimation;
  late Animation<double> textFadeAnimation;
  late Animation<double> textScaleAnimation;

  bool showMatch = false;
  List<Firework> fireworks = [];

  @override
  void onInit() {
    super.onInit();

    // Card animation controller
    cardAnimationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    // Fireworks controller
    fireworksController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Text animation controller
    textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Card animations
    card1XAnimation = Tween<double>(
      begin: 0.0,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.elasticOut,
    ));

    card2XAnimation = Tween<double>(
      begin: 0.0,
      end: -50.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.elasticOut,
    ));

    card2YAnimation = Tween<double>(
      begin: 0.0,
      end: -70.0,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.elasticOut,
    ));

    card1RotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.4,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.elasticOut,
    ));

    card2RotationAnimation = Tween<double>(
      begin: 0.0,
      end: -0.5,
    ).animate(CurvedAnimation(
      parent: cardAnimationController,
      curve: Curves.elasticOut,
    ));

    // Fireworks animation
    fireworksAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(fireworksController);

    // Text animations
    textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    textScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: textController,
      curve: Curves.elasticOut,
    ));

    // Generate fireworks
    generateFireworks();
  }

  void generateFireworks() {
    final random = math.Random();
    fireworks.clear();

    for (int i = 0; i < 15; i++) {
      fireworks.add(Firework(
        x: random.nextDouble(),
        y: random.nextDouble(),
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        delay: random.nextDouble() * 0.5,
        duration: 0.5 + random.nextDouble() * 0.5,
      ));
    }
  }

  void triggerMatchAnimation() {
    showMatch = true;
    update();

    // Start card animation
    cardAnimationController.forward();

    // Start fireworks immediately
    fireworksController.forward();

    // Start text animation with delay
    Future.delayed(Duration(milliseconds: 800), () {
      textController.forward();
    });
  }

  void resetAnimation() {
    cardAnimationController.reset();
    fireworksController.reset();
    textController.reset();
    showMatch = false;
    update();
  }

  @override
  void onClose() {
    cardAnimationController.dispose();
    fireworksController.dispose();
    textController.dispose();
    super.onClose();
  }
}

class Firework {
  final double x;
  final double y;
  final Color color;
  final double delay;
  final double duration;

  Firework({
    required this.x,
    required this.y,
    required this.color,
    required this.delay,
    required this.duration,
  });
}
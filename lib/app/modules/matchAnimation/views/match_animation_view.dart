import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import '../controllers/match_animation_controller.dart';

class MatchAnimationView extends GetView<MatchAnimationController> {
  const MatchAnimationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),

      body: GetBuilder<MatchAnimationController>(
        builder: (controller) {
          return Stack(
            children: [
              // Fireworks layer
              if (controller.showMatch)
                AnimatedBuilder(
                  animation: controller.fireworksAnimation,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: FireworksPainter(controller.fireworks, controller.fireworksAnimation.value),
                      size: Size.infinite,
                    );
                  },
                ),

              // Main content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Cards stack
                    Container(
                      height: 400,
                      width: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Card 1 (Background card) - Sarah going right and up
                          AnimatedBuilder(
                            animation: controller.cardAnimationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(controller.card1XAnimation.value, controller.card2YAnimation.value),
                                child: Transform.rotate(
                                  angle: controller.card1RotationAnimation.value,
                                  child: ProfileCard(
                                    image: 'assets/woman.jpg',
                                    name: 'Sarah',
                                    age: 24,
                                  ),
                                ),
                              );
                            },
                          ),

                          // Card 2 (Foreground card) - Alex going left
                          AnimatedBuilder(
                            animation: controller.cardAnimationController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(controller.card2XAnimation.value, 0),
                                child: Transform.rotate(
                                  angle: controller.card2RotationAnimation.value,
                                  child: ProfileCard(
                                    image: 'assets/man.jpg',
                                    name: 'Alex',
                                    age: 26,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    // Match text
                    if (controller.showMatch)
                      AnimatedBuilder(
                        animation: controller.textController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: controller.textFadeAnimation.value,
                            child: Transform.scale(
                              scale: controller.textScaleAnimation.value,
                              child: Column(
                                children: [
                                  Text(
                                    'Congratulations',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFD700),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'It\'s a match',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                    SizedBox(height: 30),

                    // Buttons
                    if (controller.showMatch)
                      AnimatedBuilder(
                        animation: controller.textController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: controller.textFadeAnimation.value,
                            child: Column(
                              children: [
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFFD700),
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Text(
                                      'Start Chatting',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  width: 300,
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: controller.resetAnimation,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Color(0xFFFFD700)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    child: Text(
                                      'Go Back to Home',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFFFFD700),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),

              // Trigger button (for demo)
              if (!controller.showMatch)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: controller.triggerMatchAnimation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFFD700),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('Trigger Match Animation'),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String image;
  final String name;
  final int age;

  const ProfileCard({
    Key? key,
    required this.image,
    required this.name,
    required this.age,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image placeholder
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF8E2DE2),
                    Color(0xFF4A00E0),
                  ],
                ),
              ),
            ),

            // Profile image placeholder
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),

            // Name and age
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$age years old',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FireworksPainter extends CustomPainter {
  final List<Firework> fireworks;
  final double animationValue;

  FireworksPainter(this.fireworks, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    for (var firework in fireworks) {
      final adjustedProgress = math.max(0.0,
          math.min(1.0, (animationValue - firework.delay) / firework.duration));

      if (adjustedProgress > 0) {
        _drawFirework(canvas, size, firework, adjustedProgress);
      }
    }
  }

  void _drawFirework(Canvas canvas, Size size, Firework firework, double progress) {
    final paint = Paint()
      ..color = firework.color.withOpacity(1.0 - progress)
      ..style = PaintingStyle.fill;

    final centerX = firework.x * size.width;
    final centerY = firework.y * size.height;
    final radius = progress * 80;

    // Draw multiple particles
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30) * math.pi / 180;
      final x = centerX + math.cos(angle) * radius;
      final y = centerY + math.sin(angle) * radius;

      canvas.drawCircle(
        Offset(x, y),
        3.0 * (1.0 - progress),
        paint,
      );
    }

    // Draw center burst
    canvas.drawCircle(
      Offset(centerX, centerY),
      10.0 * progress * (1.0 - progress),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Access the GetX controller
  final HomeController controller = Get.find<HomeController>();
  Offset position = Offset(0, 0);

  // State variables for dragging

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).width;

    bool isDragging = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[100],
        child: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy,
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    isDragging = true;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    position += details.delta;
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    isDragging = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: isDragging ? 0 : 200),
                  transform: Matrix4.identity()
                    ..scale(isDragging ? 1.05 : 1.0),
                  child: Card(
                    elevation: isDragging ? 12 : 4,
                    shadowColor: Colors.black.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      width: 250,
                      height: 260,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue.shade400,
                            Colors.purple.shade400,
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.touch_app,
                            size: 40,
                            color: Colors.white,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Draggable Card',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Touch and drag me!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Position: (${position.dx}, ${position.dy.round()})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:async';
import 'package:covid/View/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)
    ..repeat(reverse: true); // This makes the animation scale back and forth

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => WorldStatesScreen()));
    });
  }

  @override
  void dispose() {
    controller.dispose(); // Always dispose of your animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: 1.0 + controller.value * 0.5, // Scale between 1.0 and 1.5
                  child: Container(
                    child: Image.asset('assets/images/virus.png', height: 200.0, width: 200.0),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const Align(
              child: Text(
                'Covid-19 Tracker',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login/on_boarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _gradientAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Delay Splash Screen & Navigate to Next Screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView ()), // Replace with your next screen
      );
    });

    // Animation Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Gradient Animation
    _gradientAnimation = ColorTween(
      begin: Colors.orange.shade700,
      end: Colors.black,
    ).animate(_controller);

    // Slide Transition Animation (Bottom to Up)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Starts from bottom
      end: Offset.zero, // Moves to normal position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo),
    );

    _controller.forward(); // Start animation on app launch
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _gradientAnimation,
        builder: (context, child) {
          return Stack(
            children: [
              // Animated Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_gradientAnimation.value!, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Centered Curved ClipPath
              Positioned.fill(
                child: ClipPath(
                  clipper: SplashClipper(),
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ),

              // Slide Transition for Lottie & Text
              Center(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/img/animation.json',
                        width: 300, // Large size
                        height: 300,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "No Pain, No Gain! 💪",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 3),
                          ],
                        ),
                      ),
                    ],
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

// Next Screen Placeholder (Replace with Your Next Screen)
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome to the Next Screen!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Adjusted Clipper for a Better Curve Placement
class SplashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.40); // Adjusted curve placement
    path.quadraticBezierTo(size.width / 2, size.height * 0.25, size.width, size.height * 0.40);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

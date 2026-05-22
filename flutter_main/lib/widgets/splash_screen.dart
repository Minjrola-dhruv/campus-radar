import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white, // Start with pure white at the top
              Color(0xFF82B1FF), // Transition into light blue
              Color(0xFF2979FF), // End with vibrant blue at the bottom
            ],
            stops: [0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Top Right Version Text
              const Positioned(
                top: 16.0,
                right: 16.0,
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Middle Content: Logo, Slogan, Loader, and Small Text
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo with a soft shadow for depth
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.15),
                            blurRadius: 25.0,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.radar,
                        size: 80.0,
                        color: Color(0xFF2979FF),
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    
                    // App Name
                    const Text(
                      'Campus Radar',
                      style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1565C0), // Deeper blue for contrast against the lighter middle background
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    
                    // Slogan
                    const Text(
                      'Discover your campus like never before',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF424242),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    // Space
                    const SizedBox(height: 80.0),
                    
                    // Loader Widget
                    const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4.0,
                    ),
                    const SizedBox(height: 24.0),
                    
                    // Small text below loader
                    const Text(
                      'Loading awesome things...',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom Copyright
              const Positioned(
                bottom: 24.0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '© 2026 Campus Radar. All rights reserved.',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white70,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:dog_age_plus/features/auth/screens/login_screen.dart';
import 'package:dog_age_plus/features/auth/screens/signup_screen.dart';
import 'package:dog_age_plus/features/onboarding/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';

class DogAgePlusApp extends StatelessWidget {
  const DogAgePlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DogAgePlus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 11, 114, 15),
        ),
      ),
      home: const OnboardingScreen(),
      initialRoute: '/onboarding',
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}

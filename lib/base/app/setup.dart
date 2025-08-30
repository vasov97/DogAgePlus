import 'package:dog_age_plus/base/app/onboard_new.dart';
import 'package:dog_age_plus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> configureAppAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //runApp(const DogAgePlusApp());
  runApp(MaterialApp(home: const OnboardingDogHealth()));
}

import 'package:dog_age_plus/base/app/dog_age_plus_app.dart';
import 'package:dog_age_plus/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> configureAppAndRun() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DogAgePlusApp());
}

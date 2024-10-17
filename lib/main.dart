import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serve_mate/firebase_options.dart';
import 'core/services/injection_container.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  await init(); // Initialize Dependency Injection
  runApp(const MyApp()); // Run the MyApp widget
}

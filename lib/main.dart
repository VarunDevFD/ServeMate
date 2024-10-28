import 'package:flutter/material.dart';
import 'package:serve_mate/core/di/injector.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize Dependency Injection
  runApp(const MyApp()); // Run the MyApp widget
}

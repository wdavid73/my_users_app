import 'package:flutter/material.dart';
import 'package:my_users_app/app/app.dart';
import 'package:my_users_app/config/config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Optional:  Locks the app orientation to portrait mode.
  // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);

  /// Initializes the app before running the main application.
  await AppInitializer.init();

  /// Runs the main application widget.
  runApp(const MainApp());
}

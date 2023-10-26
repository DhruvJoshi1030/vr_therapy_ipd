import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/Login.dart';
import 'package:vr_therapy_ipd/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Firebase initialization

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

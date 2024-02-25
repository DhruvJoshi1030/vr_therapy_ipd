import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vr_therapy_ipd/design/introanimation/components/intro.dart';
import 'package:vr_therapy_ipd/doctor/docdata.dart';
import 'package:vr_therapy_ipd/patient/entrypage.dart';
import 'package:vr_therapy_ipd/patient/features/appointment/appointment.dart';
import 'package:vr_therapy_ipd/patient/onboarding.dart';
import 'package:vr_therapy_ipd/patient/patient_login.dart';
import 'package:vr_therapy_ipd/patient/features/progresstracker.dart';
import 'package:vr_therapy_ipd/patient/features/simulation.dart';
import 'package:vr_therapy_ipd/firebase_options.dart';
import 'package:vr_therapy_ipd/patient/questionnaire.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DoctorDataProvider>(
      create: (context) => DoctorDataProvider(),
      child: MaterialApp(
        home: IntroductionAnimationScreen(), // Replace with your initial screen
      ),
    );
  }
}

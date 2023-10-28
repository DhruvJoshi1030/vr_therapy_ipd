import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/doctor_login.dart';
import 'package:vr_therapy_ipd/onboarding.dart';
import 'package:vr_therapy_ipd/patient_login.dart';

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<EntryPage> createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VR THERAPY'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('I AM A DOCTORE'),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPageP()));
              },
              child: Text('I AM A PATIENT'),
            ),
          ],
        ),
      ),
    );
  }
}

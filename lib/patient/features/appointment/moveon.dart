import 'package:flutter/material.dart';
import 'package:vr_therapy_ipd/patient/questionnaire.dart';

class Qscreen extends StatefulWidget {
  const Qscreen({super.key});

  @override
  State<Qscreen> createState() => _QscreenState();
}

class _QscreenState extends State<Qscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              color: Colors.black,
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: InkWell(
               
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Regular Monitoring',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button tap
                          // You can navigate or perform any action here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuestionnairePage(),
                            ),
                          );
                        },
                        child: Text('Click here to take the questionnare'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

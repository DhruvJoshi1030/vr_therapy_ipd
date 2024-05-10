import 'package:flutter/material.dart';

class FinalDetect extends StatefulWidget {
  final String simulationValue;
  final String questionnaireValue;

  const FinalDetect({
    Key? key,
    required this.simulationValue,
    required this.questionnaireValue,
  }) : super(key: key);

  @override
  State<FinalDetect> createState() => _FinalDetectState();
}

class _FinalDetectState extends State<FinalDetect> {
  String determinePhobiaLevel() {
    final int simulationValue =
        int.tryParse(widget.simulationValue as String) ?? 0;
    final String questionnaireValue = widget.questionnaireValue;

    if (simulationValue > 100) {
      if (questionnaireValue == 'Yes') {
        return 'You have a phobia';
      } else {
        return 'Mild phobia';
      }
    } else {
      return 'No phobia';
    }
  }

  @override
  Widget build(BuildContext context) {
    String phobiaLevel = determinePhobiaLevel();

    return Scaffold(
      appBar: AppBar(
        title: Text('Final Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Simulation Value: ${widget.simulationValue}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Questionnaire Value: ${widget.questionnaireValue}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Phobia Level: $phobiaLevel',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

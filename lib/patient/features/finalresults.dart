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
  @override
  Widget build(BuildContext context) {
    // Access simulationValue and questionnaireValue using widget.simulationValue and widget.questionnaireValue
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
          ],
        ),
      ),
    );
  }
}

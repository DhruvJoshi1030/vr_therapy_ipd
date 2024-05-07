import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class QuestionnairePage extends StatefulWidget {
  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question':
          'Did you feel a strong sense of fear or anxiety during the VR simulation involving enclosed spaces like a lift or mining environment?yes/no',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you actively try to avoid or escape from the virtual enclosed spaces during the simulation',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you experience physical symptoms such as sweating, trembling, or an increased heart rate during the VR simulation of enclosed spaces?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you feel a sense of panic or dread that persisted throughout the virtual enclosed space exposure?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you actively avoid looking at or engaging with aspects of the VR simulation that emphasized confinement or limited space?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did the virtual enclosed spaces trigger any memories of real-life experiences that caused fear or anxiety in confined spaces?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you avoid watching the VR simulation again or express a reluctance to repeat the experience involving enclosed spaces?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did the virtual enclosed spaces trigger any negative thoughts or beliefs about yourself or your abilities?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Did you find it challenging to engage in the VR simulation due to overwhelming fear or discomfort in confined spaces?',
      'options': ['Yes', 'No'],
    },
    {
      'question':
          'Were you able to complete the entire VR therapy session without the need to stop due to claustrophobic feelings?',
      'options': ['Yes', 'No'],
    },
  ];

  String? _selectedAnswer;
  String userEmail = "";
  List<String?> selectedAnswers = [];
  String? responseBody;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        selectedAnswers.add(_selectedAnswer);
        _selectedAnswer = null;
      } else {
        // User has completed the questionnaire
        selectedAnswers.add(_selectedAnswer);
        print('Selected Answers: $selectedAnswers'); // Print selected answers

        // Send selected answers to the API
        postData(selectedAnswers);

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          setState(() {
            userEmail = user.email!;
          });
        }
      }
    });
    _animationController.reset();
    _animationController.forward();
  }

  Future<void> postData(List<String?> selectedAnswers) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://010e-2401-4900-517a-fbe1-b0ee-a1ca-499b-60d1.ngrok-free.app/predict'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_answers':
              selectedAnswers.map((answer) => answer == 'Yes' ? 1 : 0).toList(),
        }),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        print('Data posted successfully');
        print('Response: ${response.body}');
        setState(() {
          responseBody = response.body;
        });
      } else {
        // Handle error response
        print('Failed to post data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Failed to post data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                _questions[_currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Column(
                children: _questions[_currentQuestionIndex]['options']
                    .map<Widget>((option) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedAnswer = option;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedAnswer == option
                                  ? Colors.blue.withOpacity(0.5)
                                  : Colors.transparent,
                              border: Border.all(
                                color: _selectedAnswer == option
                                    ? Colors.blue
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Text(
                                    option,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                if (_selectedAnswer == option)
                                  Icon(Icons.check, color: Colors.blue),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectedAnswer != null ? _nextQuestion : null,
                child: Text('Next'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor:
                      _selectedAnswer != null ? Colors.blue : Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              if (responseBody != null) ...[
                Text(
                  'Response Body: $responseBody',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
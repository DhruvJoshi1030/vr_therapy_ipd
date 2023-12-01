import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vr_therapy_ipd/patient/onboarding.dart';
import 'package:vr_therapy_ipd/patient/register.dart';


class LoginPageP extends StatefulWidget {
  const LoginPageP({super.key});

  @override
  _LoginPagePState createState() => _LoginPagePState();
}

class _LoginPagePState extends State<LoginPageP> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Navigate to the next screen upon successful login
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true, // Hide password
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  final String email = _emailController.text.trim();
                  final String password = _passwordController.text.trim();
                  _signInWithEmailAndPassword(email, password);
                },
                child: Text('Login'),
              ),
              SizedBox(height: 10.0), // Add spacing
              TextButton(
                onPressed: () {
                  // Navigate to the registration screen when the button is pressed
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegistrationScreenP()));
                },
                child: Text('Click here to sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

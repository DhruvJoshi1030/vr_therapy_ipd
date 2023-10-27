import 'package:flutter/material.dart';

class Simulatioinscreen extends StatefulWidget {
  const Simulatioinscreen({super.key});

  @override
  State<Simulatioinscreen> createState() => _SimulatioinscreenState();
}

class _SimulatioinscreenState extends State<Simulatioinscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text('Simulation Page')],
      ),
    );
  }
}

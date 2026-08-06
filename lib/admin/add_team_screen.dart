import 'package:flutter/material.dart';

class AddTeamScreen extends StatelessWidget {
  const AddTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Team"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "Add Team Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AddTournamentScreen extends StatelessWidget {
  const AddTournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Tournament"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          "Add Tournament Screen",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMatchScreen extends StatefulWidget {
  const AddMatchScreen({super.key});

  @override
  State<AddMatchScreen> createState() => _AddMatchScreenState();
}

class _AddMatchScreenState extends State<AddMatchScreen> {
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _statusController = TextEditingController();
  final _tournamentController = TextEditingController();
  final _groundController = TextEditingController();
  final _youtubeController = TextEditingController();
  final _teamAScoreController = TextEditingController();
  final _teamBScoreController = TextEditingController();
  final _oversController = TextEditingController();

  Future<void> addMatch() async {
    await FirebaseFirestore.instance.collection('matches').add({
  'teamA': _teamAController.text.trim(),
  'teamB': _teamBController.text.trim(),
  'teamAScore': _teamAScoreController.text.trim(),
  'teamBScore': _teamBScoreController.text.trim(),
  'overs': _oversController.text.trim(),
  'status': _statusController.text.trim(),
  'tournament': _tournamentController.text.trim(),
  'ground': _groundController.text.trim(),
  'youtubeUrl': _youtubeController.text.trim(),
  'createdAt': FieldValue.serverTimestamp(),
});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Match Added Successfully"),
      ),
    );

    _teamAController.clear();
    _teamBController.clear();
    _statusController.clear();
    _tournamentController.clear();
    _groundController.clear();
    _youtubeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Match"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _teamAController,
              decoration: const InputDecoration(labelText: "Team A"),
            ),
            TextField(
              controller: _teamBController,
              decoration: const InputDecoration(labelText: "Team B"),
            ),
            TextField(
  controller: _teamAScoreController,
  decoration: const InputDecoration(
    labelText: "Team A Score (e.g. 145/4)",
  ),
),

TextField(
  controller: _teamBScoreController,
  decoration: const InputDecoration(
    labelText: "Team B Score (e.g. 140/8)",
  ),
),

TextField(
  controller: _oversController,
  decoration: const InputDecoration(
    labelText: "Overs (e.g. 18.2)",
  ),
),
            TextField(
              controller: _statusController,
              decoration: const InputDecoration(
                labelText: "Status",
              ),
            ),
            TextField(
              controller: _tournamentController,
              decoration: const InputDecoration(
                labelText: "Tournament",
              ),
            ),
            TextField(
              controller: _groundController,
              decoration: const InputDecoration(
                labelText: "Ground",
              ),
            ),
            TextField(
              controller: _youtubeController,
              decoration: const InputDecoration(
                labelText: "YouTube Live URL",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: addMatch,
              child: const Text("Save Match"),
            ),
          ],
        ),
      ),
    );
  }
}
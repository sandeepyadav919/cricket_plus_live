import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditMatchScreen extends StatefulWidget {
  final String documentId;
  final Map<String, dynamic> matchData;

  const EditMatchScreen({
    super.key,
    required this.documentId,
    required this.matchData,
  });

  @override
  State<EditMatchScreen> createState() => _EditMatchScreenState();
}

class _EditMatchScreenState extends State<EditMatchScreen> {
  late TextEditingController teamAController;
  late TextEditingController teamBController;
  late TextEditingController tournamentController;
  late TextEditingController groundController;
  late TextEditingController youtubeController;

  String status = "Upcoming";

  @override
  void initState() {
    super.initState();

    teamAController =
        TextEditingController(text: widget.matchData['teamA']);

    teamBController =
        TextEditingController(text: widget.matchData['teamB']);

    tournamentController =
        TextEditingController(text: widget.matchData['tournament']);

    groundController =
        TextEditingController(text: widget.matchData['ground']);

    youtubeController =
        TextEditingController(text: widget.matchData['youtubeUrl']);

    status = widget.matchData['status'] ?? "Upcoming";
  }

  Future<void> updateMatch() async {
    await FirebaseFirestore.instance
        .collection('matches')
        .doc(widget.documentId)
        .update({
      'teamA': teamAController.text.trim(),
      'teamB': teamBController.text.trim(),
      'status': status,
      'tournament': tournamentController.text.trim(),
      'ground': groundController.text.trim(),
      'youtubeUrl': youtubeController.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Match Updated Successfully"),
      ),
    );

    Navigator.pop(context);
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Match"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: teamAController,
              decoration: const InputDecoration(
                labelText: "Team A",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: teamBController,
              decoration: const InputDecoration(
                labelText: "Team B",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: status,
              decoration: const InputDecoration(
                labelText: "Status",
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Live",
                  child: Text("Live"),
                ),
                DropdownMenuItem(
                  value: "Upcoming",
                  child: Text("Upcoming"),
                ),
                DropdownMenuItem(
                  value: "Finished",
                  child: Text("Finished"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    status = value;
                  });
                }
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tournamentController,
              decoration: const InputDecoration(
                labelText: "Tournament",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: groundController,
              decoration: const InputDecoration(
                labelText: "Ground",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: youtubeController,
              decoration: const InputDecoration(
                labelText: "YouTube URL",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: updateMatch,
                child: const Text(
                  "Update Match",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    teamAController.dispose();
    teamBController.dispose();
    tournamentController.dispose();
    groundController.dispose();
    youtubeController.dispose();
    super.dispose();
  }
}
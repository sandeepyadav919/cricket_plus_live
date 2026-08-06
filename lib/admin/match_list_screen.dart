import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/match_model.dart';
import '../widgets/match_card.dart';
import 'add_match_screen.dart';
import 'edit_match_screen.dart';

class MatchListScreen extends StatelessWidget {
  MatchListScreen({super.key});

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      appBar: AppBar(
        title: const Text("Manage Matches"),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder<List<MatchModel>>(
        stream: firestoreService.getMatches(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final matches = snapshot.data!;

          if (matches.isEmpty) {
            return const Center(
              child: Text(
                "No Matches",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: matches.length,
            itemBuilder: (context, index) {

              final match = matches[index];

              return MatchCard(
                match: match,

                onWatch: () {},

               onEdit: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditMatchScreen(
        documentId: match.id,
        matchData: {
          'teamA': match.teamA,
          'teamB': match.teamB,
          'status': match.status,
          'tournament': match.tournament,
          'ground': match.ground,
          'youtubeUrl': match.youtubeUrl,
        },
      ),
    ),
  );
},

                onDelete: () async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Delete Match"),
      content: const Text(
        "Are you sure you want to delete this match?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Delete"),
        ),
      ],
    ),
  );

  if (confirm == true) {
    await firestoreService.deleteMatch(match.id);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Match Deleted Successfully"),
        ),
      );
    }
  }
},
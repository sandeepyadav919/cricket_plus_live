import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_match_screen.dart';
import 'add_team_screen.dart';
import 'add_tournament_screen.dart';
import 'match_list_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Cricket Plus Live Admin",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [

          // Dashboard Card
          StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('matches')
      .snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final docs = snapshot.data!.docs;

    final total = docs.length;

    final live = docs.where((e) {
      final data = e.data() as Map<String, dynamic>;
      return data['status'] == "Live";
    }).length;

    final upcoming = docs.where((e) {
      final data = e.data() as Map<String, dynamic>;
      return data['status'] == "Upcoming";
    }).length;

    final finished = docs.where((e) {
      final data = e.data() as Map<String, dynamic>;
      return data['status'] == "Finished";
    }).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              buildStat("Total", total, Colors.white),

              buildStat("Live", live, Colors.red),

              buildStat("Upcoming", upcoming, Colors.amber),

              buildStat("Finished", finished, Colors.blue),

            ],
          ),
        ],
      ),
    );
  },
),
                            
          const SizedBox(height: 30),

          buildMenu(
            context,
            Icons.add_circle,
            "Add Match",
            Colors.green,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddMatchScreen(),
                ),
              );
            },
          ),

          buildMenu(
            context,
            Icons.groups,
            "Add Team",
            Colors.blue,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddTeamScreen(),
                ),
              );
            },
          ),

          buildMenu(
            context,
            Icons.emoji_events,
            "Add Tournament",
            Colors.orange,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddTournamentScreen(),
                ),
              );
            },
          ),

          buildMenu(
            context,
            Icons.list_alt,
            "Manage Matches",
            Colors.purple,
            () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchListScreen(),
      ),
    );
  },
),

          buildMenu(
            context,
            Icons.logout,
            "Logout",
            Colors.red,
            () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildStat(
  String title,
  int value,
  Color color,
) {
  return Column(
    children: [
      Text(
        value.toString(),
        style: TextStyle(
          color: color,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ],
  );
}
}
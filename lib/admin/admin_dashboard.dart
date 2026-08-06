import 'package:flutter/material.dart';

import 'add_match_screen.dart';
import 'add_team_screen.dart';
import 'add_tournament_screen.dart';
import 'match_list_screen.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

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

          const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          buildMenu(
            context,
            Icons.add_circle,
            "Add Match",
            Colors.green,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddMatchScreen(),
                ),
              );
            },
          ),

          buildMenu(
            context,
            Icons.list_alt,
            "Manage Matches",
            Colors.blue,
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
            Icons.groups,
            "Teams",
            Colors.orange,
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
            "Tournament",
            Colors.purple,
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

  Widget buildMenu(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
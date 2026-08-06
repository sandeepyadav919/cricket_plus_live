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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Total Matches",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Live",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Upcoming",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
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
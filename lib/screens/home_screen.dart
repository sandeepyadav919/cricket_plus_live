import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/firestore_service.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();

  int tapCount = 0;

  void openAdmin() {
    tapCount++;

    if (tapCount >= 5) {
      tapCount = 0;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    }
  }

  Future<void> openYoutube(String url) async {
    if (url.isEmpty) return;

    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: GestureDetector(
          onTap: openAdmin,
          child: const Text(
            "Cricket Plus Live",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "🏏 Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Watch Local Cricket Live",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "🔴 LIVE MATCHES",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getMatches(),
            builder: (context, snapshot) {

              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "No Live Match",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (context, index) {

                  final data =
                      docs[index].data() as Map<String, dynamic>;

                  return Card(
                    color: const Color(0xFF1E293B),
                    margin: const EdgeInsets.only(bottom: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: const [

                              Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 12,
                              ),

                              SizedBox(width: 8),

                              Text(
                                "LIVE",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          Center(
                            child: Text(
                              data['teamA'] ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Center(
                            child: Text(
                              data['teamAScore'] ?? "",
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Center(
                            child: Text(
                              "VS",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Center(
                            child: Text(
                              data['teamB'] ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Center(
                            child: Text(
                              data['teamBScore'] ?? "",
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [

                              const Icon(
                                Icons.location_on,
                                color: Colors.white70,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  data['ground'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [

                              const Icon(
                                Icons.emoji_events,
                                color: Colors.amber,
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Text(
                                  data['tournament'] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {

                                openYoutube(
                                  data['youtubeUrl'] ?? "",
                                );

                              },
                              icon: const Icon(
                                Icons.play_arrow,
                              ),
                              label: const Text(
                                "WATCH LIVE",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(Icons.live_tv),
            label: "Live",
          ),

          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: "Tournament",
          ),

          NavigationDestination(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
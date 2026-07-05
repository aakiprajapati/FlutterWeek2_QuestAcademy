import 'package:flutter/material.dart';
import 'dummy_data.dart';
import 'audio_player_screen.dart';

class QuestDetailScreen extends StatelessWidget {
  final Quest quest;

  const QuestDetailScreen({super.key, required this.quest});

  Color _difficultyColor() {
    switch (quest.difficulty.toLowerCase()) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      case "low":
      default:
        return Colors.green;
    }
  }

  // reusable row: icon + label + value badge — used for all 3 stats
  Widget _statRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color badgeColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: badgeColor,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quest.title),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- IMAGE: taller + more side padding ----------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            quest.image,
                            width: double.infinity,
                            height: 340, // taller than before
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ---------- Game name + XP ----------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    quest.title,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${quest.xp} XP",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple.shade400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // ---------- Short description ----------
                              Text(
                                quest.description,
                                style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.grey),
                              ),
                              const SizedBox(height: 16),

                              // ---------- Difficulty, XP Reward, Time Limit — stacked, same style ----------
                              _statRow(
                                icon: Icons.bar_chart,
                                iconColor: _difficultyColor(),
                                label: "Difficulty",
                                value: quest.difficulty,
                                badgeColor: _difficultyColor(),
                              ),
                              _statRow(
                                icon: Icons.star,
                                iconColor: Colors.amber,
                                label: "XP Reward",
                                value: "${quest.xp} XP",
                                badgeColor: Colors.lightBlueAccent,
                              ),
                              _statRow(
                                icon: Icons.timer_outlined,
                                iconColor: Colors.deepPurple,
                                label: "Time Limit",
                                value: quest.timeLimit,
                                badgeColor: Colors.deepPurple,
                              ),

                              const Spacer(), // pushes button toward bottom, not all the way

                              // ---------- Start Quest button ----------
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AudioPlayerScreen(
                                          songName: quest.title,
                                          xpEarned: quest.xp,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    backgroundColor: Colors.deepPurple,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "Start Quest",
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
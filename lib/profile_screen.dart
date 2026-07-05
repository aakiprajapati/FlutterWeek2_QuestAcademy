import 'package:flutter/material.dart';
import 'widgets/bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ---------- Header: pfp, name, level, xp ----------
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Aaki",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Level 3 Explorer",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "XP 250/600",
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ---------- Progress loader ----------
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 250 / 600,
                minHeight: 10,
                backgroundColor: Colors.deepPurple.shade50,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            ),

            const SizedBox(height: 30),

            // ---------- Menu list ----------
            _profileTile(icon: Icons.edit, label: "Edit Profile", onTap: () {}),
            _profileTile(icon: Icons.emoji_events, label: "Badges", onTap: () {}),
            _profileTile(icon: Icons.bar_chart, label: "My Progress", onTap: () {}),
            _profileTile(icon: Icons.volume_up, label: "Audio Settings", onTap: () {}),
            _profileTile(icon: Icons.dark_mode_outlined, label: "Theme", onTap: () {}),
            _profileTile(icon: Icons.help_outline, label: "Help and Support", onTap: () {}),
            _profileTile(icon: Icons.info_outline, label: "About App", onTap: () {}),

            const Divider(height: 30),

            _profileTile(
              icon: Icons.logout,
              label: "Logout",
              color: Colors.red,
              onTap: () {},
            ),
          ],
        ),
      ),
        bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  // reusable list item — icon, label, arrow, tappable
  Widget _profileTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label, style: TextStyle(color: color, fontSize: 15)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

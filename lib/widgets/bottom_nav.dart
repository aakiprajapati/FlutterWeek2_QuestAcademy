import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../profile_screen.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;

  const AppBottomNav({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomeScreen();
        break;
      case 1:
        nextScreen = const HomeScreen();
        break;
      case 2:
        nextScreen = const HomeScreen();
        break;
      case 3:
      default:
        nextScreen = const ProfileScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      backgroundColor: Colors.deepPurple,       // ← purple bar background
      type: BottomNavigationBarType.fixed,      // ← forces bg color to actually show (see note below)
      selectedItemColor: Colors.white,          // ← active tab: solid white
      unselectedItemColor: Colors.white70,      // ← inactive tabs: slightly faded white
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Quests"),
        BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: "Leaderboard"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
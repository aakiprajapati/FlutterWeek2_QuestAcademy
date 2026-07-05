class Quest {
  final String title;
  final String image;
  final String description;
  final int xp;

  Quest({
    required this.title,
    required this.image,
    required this.description,
    required this.xp,
  });
}

class Achievement {
  final String title;
  final String icon;

  Achievement({required this.title, required this.icon});
}

// Dummy quest list (used in GridView)
List<Quest> dummyQuests = [
  Quest(title: "Dart Basics", image: "assets/images/quest1.png", description: "Learn variables, loops, and functions in Dart.", xp: 50),
  Quest(title: "Firebase", image: "assets/images/quest2.png", description: "Master backend development, user authentication, databases, and app hosting.", xp: 70),
  Quest(title: "Flutter", image: "assets/images/quest3.png", description: "Learn how to move between screens.", xp: 60),
  Quest(title: "UI Design", image: "assets/images/quest4.png", description: "Understand the beauty of designing.", xp: 90),
];

// Dummy achievements (used in horizontal ListView)
List<Achievement> dummyAchievements = [
  Achievement(title: "First Quest", icon: "assets/images/badge1.png"),
  Achievement(title: "5 Day Streak", icon: "assets/images/badge2.png"),
  Achievement(title: "Quiz Master", icon: "assets/images/badge3.png"),
  Achievement(title: "Speed Runner", icon: "assets/images/badge4.png"),
];

// Carousel banner images
List<String> carouselImages = [
  "assets/images/banner1.png",
  "assets/images/banner2.png",
  "assets/images/banner3.png",
];

List<Quest> miniQuests = [
  Quest(title: "Quiz", image: "assets/images/quiz.png", description: "Test your knowledge with quick quizzes.", xp: 30),
  Quest(title: "Memory Game", image: "assets/images/memory.png", description: "Sharpen your memory with fun matching games.", xp: 40),
  Quest(title: "Puzzle", image: "assets/images/puzzle.png", description: "Solve puzzles to earn XP.", xp: 35),
  Quest(title: "Code Challenge", image: "assets/images/code_challenge.png", description: "Solve coding challenges to level up.", xp: 60),
  Quest(title: "Flash Cards", image: "assets/images/flashcards.png", description: "Review concepts using flash cards.", xp: 25),
  Quest(title: "Vocabulary", image: "assets/images/vocabulary.png", description: "Build your vocabulary daily.", xp: 20),
];
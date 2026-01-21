import 'package:flutter/material.dart';

class OnboardingProvider with ChangeNotifier {
  final PageController pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;
  bool get isLastPage => _currentPage == 2;

  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }

  void nextPage(BuildContext context) {
    if (isLastPage) {
      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

// Placeholder for the main application screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MindMapAI Home')),
      body: const Center(child: Text('Welcome to the main application!')),
    );
  }
}

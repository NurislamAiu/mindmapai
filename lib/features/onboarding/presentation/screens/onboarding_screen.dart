import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_visual_1.dart';
import '../widgets/onboarding_visual_2.dart';
import '../widgets/onboarding_visual_3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late final ValueNotifier<double> _pageNotifier;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageNotifier = ValueNotifier<double>(0.0);
    _pageController.addListener(() {
      _pageNotifier.value = _pageController.page ?? 0.0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageNotifier.dispose();
    super.dispose();
  }

  void _onNext() {
    HapticFeedback.lightImpact();
    if (_pageNotifier.value.round() == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      body: SafeArea(
        child: ValueListenableBuilder<double>(
          valueListenable: _pageNotifier,
          builder: (context, page, child) {
            final currentPageIndex = page.round();
            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: <Widget>[
                      OnboardingPage(
                        title: 'Every great idea starts small',
                        subtitle:
                            'Even a simple thought can become something powerful.',
                        visual:
                            OnboardingVisual1(isVisible: currentPageIndex == 0),
                        pageIndex: 0,
                        currentPage: page,
                      ),
                      OnboardingPage(
                        title: 'We turn ideas into clarity',
                        subtitle:
                            'MindMapAI breaks your thoughts into clear, visual building blocks.',
                        visual:
                            OnboardingVisual2(isVisible: currentPageIndex == 1),
                        pageIndex: 1,
                        currentPage: page,
                      ),
                      OnboardingPage(
                        title: 'See it. Understand it. Build it.',
                        subtitle:
                            'Your idea is now clear and ready to move forward.',
                        visual:
                            OnboardingVisual3(isVisible: currentPageIndex == 2),
                        pageIndex: 2,
                        currentPage: page,
                      ),
                    ],
                  ),
                ),
                _buildBottomControls(currentPageIndex),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomControls(int currentPage) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: currentPage == index ? 24.0 : 8.0,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? Colors.indigo
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E2F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0,
              ),
              onPressed: _onNext,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.5),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  currentPage == 2 ? 'Start Mapping' : 'Next',
                  key: ValueKey<int>(currentPage),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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

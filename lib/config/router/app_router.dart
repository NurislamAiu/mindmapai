import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/ideas/presentation/screens/ideas_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

// Private navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/ideas',
              builder: (context, state) => const IdeasScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/explore',
              builder: (context, state) => const ExploreScreen(), // <-- ЗАМЕНА
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const _PlaceholderPage(title: 'Profile', color: Colors.orange),
            ),
          ],
        ),
      ],
    ),
  ],
);

// Простой плейсхолдер
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final Color color;
  const _PlaceholderPage({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

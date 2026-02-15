import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/auth/presentation/screens/auth_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/check_email_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/deep_link_success_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/profile_setup_screen.dart';
import 'package:mindmapai/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindmapai/features/upgrade/presentation/screens/go_pro_screen.dart';
import 'package:mindmapai/features/upgrade/presentation/screens/upgrade_screen.dart';
import '../../features/explore/presentation/screens/explore_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/ideas/presentation/screens/ideas_screen.dart';
import '../../features/main/presentation/screens/main_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';

// Private navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/home',
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
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/check-email',
      builder: (context, state) {
        final email = state.extra as String? ?? 'your-email@example.com';
        return CheckEmailScreen(email: email);
      },
    ),
    GoRoute(
      path: '/deep-link-success',
      builder: (context, state) => const DeepLinkSuccessScreen(),
    ),
    GoRoute(
      path: '/profile-setup',
      builder: (context, state) => const ProfileSetupScreen(),
    ),
    GoRoute(
      path: '/upgrade',
      builder: (context, state) => const UpgradeScreen(),
    ),
    GoRoute( // <-- НОВЫЙ МАРШРУТ
      path: '/go-pro',
      builder: (context, state) => const GoProScreen(),
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
              builder: (context, state) => const ExploreScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/ai_loading/presentation/screens/ai_loading_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/auth_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/check_email_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/deep_link_success_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/profile_setup_screen.dart';
import 'package:mindmapai/features/auth/presentation/screens/welcome_screen.dart';
import 'package:mindmapai/features/compare/presentation/screens/compare_screen.dart';
import 'package:mindmapai/features/contact_support/presentation/screens/contact_support_screen.dart';
import 'package:mindmapai/features/explore/domain/entities/explore_template.dart';
import 'package:mindmapai/features/feedback/presentation/screens/send_feedback_screen.dart';
import 'package:mindmapai/features/guided_input/presentation/screens/guided_input_screen.dart';
import 'package:mindmapai/features/help_support/presentation/screens/help_support_screen.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import 'package:mindmapai/features/profile/presentation/screens/profile_screen.dart';
import 'package:mindmapai/features/report_problem/presentation/screens/report_problem_screen.dart';
import 'package:mindmapai/features/settings/presentation/screens/privacy_policy_screen.dart';
import 'package:mindmapai/features/settings/presentation/screens/settings_screen.dart';
import 'package:mindmapai/features/settings/presentation/screens/terms_of_service_screen.dart';
import 'package:mindmapai/features/upgrade/presentation/screens/ai_credits_screen.dart';
import 'package:mindmapai/features/upgrade/presentation/screens/go_pro_screen.dart';
import 'package:mindmapai/features/upgrade/presentation/screens/upgrade_screen.dart';
import 'package:mindmapai/features/result/presentation/screens/result_screen.dart';
import 'package:mindmapai/features/version_history/presentation/screens/version_history_screen.dart';
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
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/upgrade',
      builder: (context, state) => const UpgradeScreen(),
    ),
    GoRoute(
      path: '/go-pro',
      builder: (context, state) => const GoProScreen(),
    ),
    GoRoute(
      path: '/ai-credits',
      builder: (context, state) => AICreditsScreen(
        onGetCredits: () => context.push('/upgrade'),
        onGoPro: () => context.push('/go-pro'),
        onViewHistory: () => context.push('/version-history'),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => const PrivacyPolicyScreen(),
    ),
    GoRoute(
      path: '/terms-of-service',
      builder: (context, state) => const TermsOfServiceScreen(),
    ),
    GoRoute(
      path: '/help-support',
      builder: (context, state) => const HelpSupportScreen(),
    ),
    GoRoute(
      path: '/contact-support',
      builder: (context, state) => const ContactSupportScreen(),
    ),
    GoRoute(
      path: '/send-feedback',
      builder: (context, state) => const SendFeedbackScreen(),
    ),
    GoRoute(
      path: '/report-problem',
      builder: (context, state) => const ReportProblemScreen(),
    ),
    GoRoute(
      path: '/result',
      builder: (context, state) => const ResultScreen(),
    ),
    GoRoute(
      path: '/version-history',
      builder: (context, state) => const VersionHistoryScreen(),
    ),
    GoRoute(
      path: '/compare',
      builder: (context, state) {
        final previousVersionId = state.uri.queryParameters['previous'];
        final currentVersionId = state.uri.queryParameters['current'];
        return CompareScreen(
          previousVersionId: previousVersionId,
          currentVersionId: currentVersionId,
        );
      },
    ),
    GoRoute(
      path: '/guided-input',
      builder: (context, state) {
        final template = state.extra as TemplatePreview?;
        return GuidedInputScreen(template: template);
      },
    ),
    GoRoute(
      path: '/ai-loading',
      builder: (context, state) => const AiLoadingScreen(),
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

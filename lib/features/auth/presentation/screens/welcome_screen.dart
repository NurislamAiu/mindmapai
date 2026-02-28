import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  SizedBox(
                    height: 128,
                    width: 128,
                    child: Image.asset('assets/icon/icon.png'),
                  )
                      .animate()
                      .fade(delay: 200.ms)
                      .scale(
                        begin: const Offset(0.9, 0.9),
                        duration: 800.ms,
                        curve: Curves.easeOutCubic,
                      ),
                  const Gap(48),

                  // Headline
                  Text(
                    'Welcome to MindMapAI',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E1E2F),
                    ),
                  )
                      .animate()
                      .fade(delay: 400.ms)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic, duration: 600.ms),
                  const Gap(16),

                  // Explanation
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Transform your thoughts into structured visual mind maps. Refine your ideas with AI-powered insights and watch them evolve.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  )
                      .animate()
                      .fade(delay: 500.ms)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic, duration: 600.ms),
                  const Gap(32),

                  // Credits highlight card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.indigo.shade100.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.indigo.shade50,
                          const Color(0xFFF5F3FF),
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Iconsax.magic_star,
                            color: Colors.indigo.shade600,
                            size: 24,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You've received 2 free AI credits",
                                style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF374151),
                                ),
                              ),
                              const Gap(2),
                              Text(
                                '1 credit = 1 full idea analysis or refinement',
                                style: textTheme.bodySmall?.copyWith(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fade(delay: 600.ms)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic, duration: 600.ms),
                  const Gap(48),

                  // Primary button
                  ElevatedButton.icon(
                    icon: const Icon(Iconsax.arrow_right_3, size: 20),
                    label: const Text('Start analyzing ideas'),
                    onPressed: () {
                      context.go('/home');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: const Color(0xFF4F46E5),
                      foregroundColor: Colors.white,
                      textStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      shadowColor: colors.primary.withOpacity(0.2),
                    ),
                  )
                      .animate()
                      .fade(delay: 700.ms)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic, duration: 600.ms),
                  const Gap(16),

                  // Secondary option
                  TextButton(
                    onPressed: () {
                      context.go('/explore');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade800,
                      textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Explore templates first'),
                  )
                      .animate()
                      .fade(delay: 800.ms)
                      .slideY(begin: 0.5, curve: Curves.easeOutCubic, duration: 600.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/home/domain/entities/idea.dart';
import 'package:mindmapai/features/home/domain/entities/template_preview.dart';
import 'package:mindmapai/features/home/presentation/widgets/existing_user_content.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_focus_card.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_header.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_quick_actions_row.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_subtitle.dart';
import 'package:mindmapai/features/home/presentation/widgets/new_user_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // --- SIMULATING AN EXISTING USER ---
    final List<Idea> recentIdeas = [
      Idea(
        id: 1,
        title: 'My Great Startup Idea',
        summary: 'A new way to connect people.',
        date: '1d ago',
        status: IdeaStatus.Analyzed,
      ),
      Idea(
        id: 2,
        title: 'A new concept for an app',
        summary: 'Revolutionizing the way we learn.',
        date: '3d ago',
        status: IdeaStatus.Draft,
      ),
    ];
    const creditsRemaining = 2;
    const hasIdeas = true; // Set to `false` to see the new user view
    /// НАДО ПОРАБОТАТЬ ЕСЛИ ПОЛЬЗОВАТЕЛЬ НОВЫЙ

    // --- MOCK DATA FOR TEMPLATE PREVIEWS ---
    final popularTemplates = [
      const TemplatePreview(
        title: 'Business Strategy',
        subtitle: 'Structure your business ideas with guided AI prompts',
        icon: Iconsax.briefcase,
      ),
      const TemplatePreview(
        title: 'Learning Goals',
        subtitle: 'Break down complex topics into learning paths',
        icon: Iconsax.teacher,
      ),
      const TemplatePreview(
        title: 'Project Planning',
        subtitle: 'Map out project phases, tasks, and dependencies',
        icon: Iconsax.flag,
      ),
    ];

    final focusData = hasIdeas
        ? ContinueFocusData(
            ideaTitle: 'Product roadmap planning',
            timeSince: '3 days ago',
            progress: 0.65,
          )
        : RecommendedFocusData(
            title: 'Recommended next step',
            subtitle:
                'Try analyzing your first idea to see how AI can help structure your thinking.',
          );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0x33F5F3FF), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    HomeHeader(creditsRemaining: creditsRemaining),
                    const SizedBox(height: 8),
                    const HomeSubtitle(),
                    const SizedBox(height: 24),

                    if (hasIdeas)
                      ExistingUserContent(
                        focusData: focusData,
                        recentIdeas: recentIdeas,
                      )
                    else
                      NewUserContent(templates: popularTemplates),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

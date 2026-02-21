import 'package:flutter/material.dart';
import 'package:mindmapai/features/home/data/repositories/showcase_repository.dart';
import 'package:mindmapai/features/home/domain/entities/showcase_idea.dart';
import 'package:mindmapai/features/home/presentation/widgets/home_showcase_card.dart';

class HomeShowcaseSection extends StatelessWidget {
  const HomeShowcaseSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Data is now fetched from the repository, adhering to Clean Architecture.
    final List<ShowcaseIdea> showcaseIdeas =
        ShowcaseRepository().getShowcaseIdeas();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Get Inspired',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: showcaseIdeas.length,
            // Add padding to ensure shadows are not clipped
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return HomeShowcaseCard(idea: showcaseIdeas[index]);
            },
          ),
        ),
      ],
    );
  }
}

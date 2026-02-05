import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';
import 'home_idea_list_item.dart';

class RecentIdeasSection extends StatelessWidget {
  final List<Idea> ideas;

  const RecentIdeasSection({super.key, required this.ideas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Recent ideas',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12.0),
        ListView.separated(
          itemCount: ideas.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return IdeaListItem(idea: ideas[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        ),
      ],
    );
  }
}

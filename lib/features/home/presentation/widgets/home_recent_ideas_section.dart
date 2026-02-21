import 'package:flutter/material.dart';
import '../../domain/entities/idea.dart';
import 'home_idea_list_item.dart';

class HomeRecentIdeasSection extends StatelessWidget {
  final List<Idea> ideas;

  const HomeRecentIdeasSection({super.key, required this.ideas});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            'Recent ideas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        ListView.separated(
          itemCount: ideas.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return HomeIdeaListItem(idea: ideas[index], index: index);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        ),
      ],
    );
  }
}

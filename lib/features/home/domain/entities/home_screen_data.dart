import 'idea.dart';

class HomeScreenData {
  final int creditsRemaining;
  final List<Idea> recentIdeas;
  final Idea? lastIdea;

  HomeScreenData({
    required this.creditsRemaining,
    required this.recentIdeas,
    this.lastIdea,
  });

  bool get hasIdeas => recentIdeas.isNotEmpty;
}

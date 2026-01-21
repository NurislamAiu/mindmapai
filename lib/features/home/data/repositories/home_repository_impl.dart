import '../../domain/entities/home_screen_data.dart';
import '../../domain/entities/idea.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeScreenData> getHomeScreenData() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, this data would come from an API or local database
    final recentIdeas = [
      Idea(
        id: 1,
        title: "Mobile app redesign",
        summary: "Exploring user-centered design principles for better engagement",
        date: "2 hours ago",
        status: IdeaStatus.Analyzed,
      ),
      Idea(
        id: 2,
        title: "Q1 marketing strategy",
        summary: "Breaking down channels, budget allocation, and timeline",
        date: "Yesterday",
        status: IdeaStatus.Analyzed,
      ),
      Idea(
        id: 3,
        title: "Product roadmap planning",
        summary: "Feature prioritization and development phases",
        date: "3 days ago",
        status: IdeaStatus.Draft,
      ),
    ];

    return HomeScreenData(
      creditsRemaining: 2,
      recentIdeas: recentIdeas,
      lastIdea: recentIdeas.last, // Use the last one as the "continue" idea
    );
  }
}

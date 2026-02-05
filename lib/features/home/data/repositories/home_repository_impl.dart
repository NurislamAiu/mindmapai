import '../../domain/entities/home_screen_data.dart';
import '../../domain/entities/idea.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  // Mock data for the entire app
  final List<Idea> _allIdeas = [
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
    Idea(
      id: 4,
      title: "Team structure redesign",
      summary: "Exploring organizational models for better collaboration",
      date: "5 days ago",
      status: IdeaStatus.Analyzed,
    ),
    Idea(
      id: 5,
      title: "Content strategy proposal",
      summary: "Multi-channel approach to audience engagement",
      date: "1 week ago",
      status: IdeaStatus.Draft,
    ),
  ];
  
  @override
  Future<HomeScreenData> getHomeScreenData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return HomeScreenData(
      creditsRemaining: 2,
      recentIdeas: _allIdeas.take(3).toList(),
      lastIdea: _allIdeas.firstWhere((idea) => idea.status == IdeaStatus.Draft),
    );
  }

  @override
  Future<List<Idea>> getAllIdeas() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _allIdeas;
  }
}

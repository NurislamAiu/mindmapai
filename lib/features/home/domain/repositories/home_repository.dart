import '../entities/home_screen_data.dart';
import '../entities/idea.dart';

abstract class HomeRepository {
  Future<HomeScreenData> getHomeScreenData();
  Future<List<Idea>> getAllIdeas();
}

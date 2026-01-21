import '../entities/home_screen_data.dart';

abstract class HomeRepository {
  Future<HomeScreenData> getHomeScreenData();
}

import '../entities/home_screen_data.dart';
import '../repositories/home_repository.dart';

class GetHomeScreenData {
  final HomeRepository repository;

  GetHomeScreenData(this.repository);

  Future<HomeScreenData> call() {
    return repository.getHomeScreenData();
  }
}

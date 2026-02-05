import '../entities/explore_template.dart';
import '../repositories/explore_repository.dart';

// Этот use case будет возвращать кортеж (tuple) с обоими типами данных
class GetExploreData {
  final ExploreRepository repository;

  GetExploreData(this.repository);

  Future<(Template, List<Template>)> call() async {
    // Выполняем оба запроса параллельно для эффективности
    final results = await Future.wait([
      repository.getRecommendedTemplate(),
      repository.getPopularTemplates(),
    ]);
    return (results[0] as Template, results[1] as List<Template>);
  }
}

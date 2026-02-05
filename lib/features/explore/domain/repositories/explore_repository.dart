import '../entities/explore_template.dart';

abstract class ExploreRepository {
  Future<List<Template>> getPopularTemplates();
  Future<Template> getRecommendedTemplate();
}

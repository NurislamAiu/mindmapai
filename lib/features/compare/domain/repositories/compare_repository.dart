import '../entities/mind_map_version_entity.dart';

abstract class CompareRepository {
  Future<List<MindMapVersionEntity>> getAllVersions(String ideaId);
}

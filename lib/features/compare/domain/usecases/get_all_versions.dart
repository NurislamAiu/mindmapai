import '../entities/mind_map_version_entity.dart';
import '../repositories/compare_repository.dart';

class GetAllVersions {
  final CompareRepository repository;

  GetAllVersions(this.repository);

  Future<List<MindMapVersionEntity>> call(String ideaId) {
    return repository.getAllVersions(ideaId);
  }
}

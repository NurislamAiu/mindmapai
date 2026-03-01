import '../entities/version_entity.dart';
import '../repositories/version_history_repository.dart';

class GetVersionHistory {
  final VersionHistoryRepository repository;

  GetVersionHistory(this.repository);

  Future<List<VersionEntity>> call(String ideaId) {
    return repository.getVersionHistory(ideaId);
  }
}

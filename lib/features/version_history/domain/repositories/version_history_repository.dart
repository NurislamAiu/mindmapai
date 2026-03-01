import '../entities/version_entity.dart';

abstract class VersionHistoryRepository {
  Future<List<VersionEntity>> getVersionHistory(String ideaId);
}

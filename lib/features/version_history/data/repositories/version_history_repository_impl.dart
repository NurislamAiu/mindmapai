import '../../domain/entities/version_entity.dart';
import '../../domain/repositories/version_history_repository.dart';
import '../datasources/version_history_local_data_source.dart';

class VersionHistoryRepositoryImpl implements VersionHistoryRepository {
  final VersionHistoryLocalDataSource localDataSource;

  VersionHistoryRepositoryImpl({required this.localDataSource});

  @override
  Future<List<VersionEntity>> getVersionHistory(String ideaId) {
    // В реальном приложении здесь будет логика:
    // сначала идем в сеть, если нет - в кэш.
    // Для примера, просто берем моковые данные.
    return localDataSource.getVersions();
  }
}

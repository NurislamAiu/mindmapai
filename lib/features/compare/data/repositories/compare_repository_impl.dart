import '../../domain/entities/mind_map_version_entity.dart';
import '../../domain/repositories/compare_repository.dart';
import '../datasources/compare_local_data_source.dart';

class CompareRepositoryImpl implements CompareRepository {
  final CompareLocalDataSource localDataSource;

  CompareRepositoryImpl({required this.localDataSource});

  @override
  Future<List<MindMapVersionEntity>> getAllVersions(String ideaId) {
    return localDataSource.getVersions();
  }
}

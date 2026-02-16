import 'package:mindmapai/features/help_support/data/datasources/help_support_local_data_source.dart';
import 'package:mindmapai/features/help_support/domain/entities/help_support_data.dart';
import 'package:mindmapai/features/help_support/domain/repositories/help_support_repository.dart';

class HelpSupportRepositoryImpl implements HelpSupportRepository {
  final HelpSupportLocalDataSource localDataSource;

  HelpSupportRepositoryImpl({required this.localDataSource});

  @override
  Future<HelpSupportData> getHelpSupportData() {
    return localDataSource.getHelpSupportData();
  }
}

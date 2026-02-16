import 'package:mindmapai/features/help_support/domain/entities/help_support_data.dart';
import 'package:mindmapai/features/help_support/domain/repositories/help_support_repository.dart';

class GetHelpSupportData {
  final HelpSupportRepository repository;

  GetHelpSupportData(this.repository);

  Future<HelpSupportData> call() {
    return repository.getHelpSupportData();
  }
}

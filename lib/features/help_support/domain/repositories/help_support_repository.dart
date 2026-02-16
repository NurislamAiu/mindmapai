import 'package:mindmapai/features/help_support/domain/entities/help_support_data.dart';

abstract class HelpSupportRepository {
  Future<HelpSupportData> getHelpSupportData();
}

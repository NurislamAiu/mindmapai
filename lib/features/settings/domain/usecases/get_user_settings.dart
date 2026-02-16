import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/domain/repositories/settings_repository.dart';

class GetUserSettings {
  final SettingsRepository repository;

  GetUserSettings(this.repository);

  Future<UserSettings> call() async {
    return await repository.getUserSettings();
  }
}

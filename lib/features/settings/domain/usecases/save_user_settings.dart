import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/domain/repositories/settings_repository.dart';

class SaveUserSettings {
  final SettingsRepository repository;

  SaveUserSettings(this.repository);

  Future<void> call(UserSettings settings) async {
    return await repository.saveUserSettings(settings);
  }
}

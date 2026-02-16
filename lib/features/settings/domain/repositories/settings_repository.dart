import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';

abstract class SettingsRepository {
  Future<UserProfile> getUserProfile();
  Future<UserSettings> getUserSettings();
  Future<void> saveUserSettings(UserSettings settings);
}

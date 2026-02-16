import 'package:mindmapai/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<UserProfile> getUserProfile() async {
    return await localDataSource.getUserProfile();
  }

  @override
  Future<UserSettings> getUserSettings() async {
    return await localDataSource.getUserSettings();
  }

  @override
  Future<void> saveUserSettings(UserSettings settings) async {
    await localDataSource.saveUserSettings(settings);
  }
}

import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';

abstract class SettingsLocalDataSource {
  Future<UserProfile> getUserProfile();
  Future<UserSettings> getUserSettings();
  Future<void> saveUserSettings(UserSettings settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  // In-memory storage for mock data
  UserProfile _userProfile = const UserProfile(
    name: "Nurislam Ilyassov",
    email: "nurislamilyasov@gmail.com",
    subscriptionStatus: SubscriptionStatus.pro,
    credits: 3,
  );

  UserSettings _userSettings = const UserSettings(
    analysisDepth: AnalysisDepth.standard,
    mindMapLayout: MindMapLayout.radial,
    autoSaveVersions: true,
    hapticFeedback: true,
  );

  @override
  Future<UserProfile> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _userProfile;
  }

  @override
  Future<UserSettings> getUserSettings() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _userSettings;
  }

  @override
  Future<void> saveUserSettings(UserSettings settings) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    _userSettings = settings;
  }
}

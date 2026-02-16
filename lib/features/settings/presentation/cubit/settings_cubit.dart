import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_profile.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_settings.dart';
import 'package:mindmapai/features/settings/domain/usecases/save_user_settings.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetUserProfile getUserProfile;
  final GetUserSettings getUserSettings;
  final SaveUserSettings saveUserSettings;

  SettingsCubit({
    required this.getUserProfile,
    required this.getUserSettings,
    required this.saveUserSettings,
  }) : super(SettingsInitial());

  Future<void> loadSettings() async {
    try {
      emit(SettingsLoading());
      final userProfile = await getUserProfile();
      final userSettings = await getUserSettings();
      emit(SettingsLoaded(userProfile: userProfile, userSettings: userSettings));
    } catch (e) {
      emit(SettingsError(message: 'Failed to load settings: $e'));
    }
  }

  void _saveAndApplySettings(UserSettings newSettings) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(userSettings: newSettings));
      saveUserSettings(newSettings);
    }
  }

  void updateAnalysisDepth(AnalysisDepth depth) {
    if (state is SettingsLoaded) {
      final newSettings = (state as SettingsLoaded).userSettings.copyWith(analysisDepth: depth);
      _saveAndApplySettings(newSettings);
    }
  }

  void updateMindMapLayout(MindMapLayout layout) {
    if (state is SettingsLoaded) {
      final newSettings = (state as SettingsLoaded).userSettings.copyWith(mindMapLayout: layout);
      _saveAndApplySettings(newSettings);
    }
  }

  void updateAutoSave(bool value) {
    if (state is SettingsLoaded) {
      final newSettings = (state as SettingsLoaded).userSettings.copyWith(autoSaveVersions: value);
      _saveAndApplySettings(newSettings);
    }
  }

  void updateHapticFeedback(bool value) {
    if (state is SettingsLoaded) {
      final newSettings = (state as SettingsLoaded).userSettings.copyWith(hapticFeedback: value);
      _saveAndApplySettings(newSettings);
    }
  }
}

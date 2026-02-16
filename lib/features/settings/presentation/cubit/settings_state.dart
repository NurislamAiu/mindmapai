import 'package:equatable/equatable.dart';
import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserProfile userProfile;
  final UserSettings userSettings;

  const SettingsLoaded({required this.userProfile, required this.userSettings});

  @override
  List<Object> get props => [userProfile, userSettings];

  SettingsLoaded copyWith({
    UserProfile? userProfile,
    UserSettings? userSettings,
  }) {
    return SettingsLoaded(
      userProfile: userProfile ?? this.userProfile,
      userSettings: userSettings ?? this.userSettings,
    );
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message});

  @override
  List<Object> get props => [message];
}

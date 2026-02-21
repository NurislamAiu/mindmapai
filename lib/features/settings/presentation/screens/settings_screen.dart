import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:mindmapai/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_profile.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_settings.dart';
import 'package:mindmapai/features/settings/domain/usecases/save_user_settings.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:mindmapai/features/settings/presentation/screens/settings_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = SettingsLocalDataSourceImpl();
    final repository = SettingsRepositoryImpl(localDataSource: dataSource);
    final getUserProfile = GetUserProfile(repository);
    final getUserSettings = GetUserSettings(repository);
    final saveUserSettings = SaveUserSettings(repository);

    return BlocProvider(
      create: (context) => SettingsCubit(
        getUserProfile: getUserProfile,
        getUserSettings: getUserSettings,
        saveUserSettings: saveUserSettings,
      )..loadSettings(),
      child: const SettingsView(),
    );
  }
}

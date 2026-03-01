import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_state.dart';
import 'package:mindmapai/features/settings/presentation/widgets/app_info.dart';
import 'package:mindmapai/features/settings/presentation/widgets/profile_section.dart';
import 'package:mindmapai/features/settings/presentation/widgets/segmented_setting.dart';
import 'package:mindmapai/features/settings/presentation/widgets/setting_item.dart';
import 'package:mindmapai/features/settings/presentation/widgets/setting_toggle.dart';
import 'package:mindmapai/features/settings/presentation/widgets/settings_dialogs.dart';
import 'package:mindmapai/features/settings/presentation/widgets/settings_group.dart';
import 'package:mindmapai/features/settings/presentation/widgets/settings_shimmer.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'Settings'),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return const SettingsShimmer();
          }
          if (state is SettingsError) {
            return Center(child: Text(state.message));
          }
          if (state is SettingsLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Manage your account and preferences',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 24),
                  ProfileSection(userProfile: state.userProfile)
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0),
                  SettingsGroup(
                    title: 'AI & Credits',
                    children: [
                      SettingItem(
                        icon: Iconsax.star,
                        label: 'AI Credits',
                        value: '${state.userProfile.credits} remaining',
                        onTap: () => context.push('/ai-credits'),
                      ),
                      SettingItem(
                        icon: Iconsax.document_text,
                        label: 'Version history',
                        onTap: () => showFeatureNotImplementedSnackBar(context, 'Version history'),
                      ),
                      SettingItem(
                        icon: Iconsax.chart,
                        label: 'Usage history',
                        onTap: () => showFeatureNotImplementedSnackBar(context, 'Usage history'),
                      ),
                      SettingItem(
                        icon: Iconsax.crown,
                        label: 'Manage subscription',
                        onTap: () => context.push('/go-pro'),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  SettingsGroup(
                    title: 'Preferences',
                    children: [
                      SegmentedSetting<AnalysisDepth>(
                        icon: Iconsax.setting_2,
                        label: 'Default analysis depth',
                        selectedValue: state.userSettings.analysisDepth,
                        onChanged: (value) =>
                            context.read<SettingsCubit>().updateAnalysisDepth(value),
                        options: const {
                          AnalysisDepth.standard: 'Standard',
                          AnalysisDepth.deep: 'Deep',
                        },
                      ),
                      SegmentedSetting<MindMapLayout>(
                        icon: Iconsax.layer,
                        label: 'Default mind map layout',
                        selectedValue: state.userSettings.mindMapLayout,
                        onChanged: (value) =>
                            context.read<SettingsCubit>().updateMindMapLayout(value),
                        options: const {
                          MindMapLayout.radial: 'Radial',
                          MindMapLayout.tree: 'Tree',
                          MindMapLayout.organic: 'Organic',
                        },
                      ),
                      SettingToggle(
                        icon: Iconsax.document_upload,
                        label: 'Auto-save versions',
                        value: state.userSettings.autoSaveVersions,
                        onChanged: (value) {
                          HapticFeedback.lightImpact();
                          context.read<SettingsCubit>().updateAutoSave(value);
                        }
                      ),
                      SettingToggle(
                        icon: Iconsax.notification_bing,
                        label: 'Haptic feedback',
                        value: state.userSettings.hapticFeedback,
                        onChanged: (value) {
                          HapticFeedback.lightImpact();
                          context.read<SettingsCubit>().updateHapticFeedback(value);
                        }
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  SettingsGroup(
                    title: 'Data & Privacy',
                    children: [
                      SettingItem(
                        icon: Iconsax.import,
                        label: 'Export all data',
                        onTap: () => showFeatureNotImplementedSnackBar(context, 'Export all data'),
                      ),
                      SettingItem(
                        icon: Iconsax.trash,
                        label: 'Clear idea history',
                        onTap: () => showFeatureNotImplementedSnackBar(context, 'Clear idea history'),
                      ),
                      SettingItem(
                        icon: Iconsax.shield_tick,
                        label: 'Privacy policy',
                        onTap: () => context.push('/privacy-policy'),
                      ),
                      SettingItem(
                        icon: Iconsax.document,
                        label: 'Terms of service',
                        onTap: () => context.push('/terms-of-service'),
                      ),
                      SettingItem(
                        icon: Iconsax.user_remove,
                        label: 'Delete account',
                        color: Colors.red.shade600,
                        iconContainerColor: Colors.red.shade50,
                        onTap: () => showDeleteAccountDialog(context),
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  SettingsGroup(
                    title: 'Support',
                    children: [
                      SettingItem(
                        icon: Iconsax.message,
                        label: 'Contact support',
                        onTap: () => context.push('/contact-support'),
                      ),
                      SettingItem(
                        icon: Iconsax.edit,
                        label: 'Send feedback',
                        onTap: () => context.push('/send-feedback'),
                      ),
                      SettingItem(
                        icon: Iconsax.info_circle,
                        label: 'FAQ',
                        onTap: () => context.push('/help-support'),
                      ),
                    ],
                  ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  const AppInfo()
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

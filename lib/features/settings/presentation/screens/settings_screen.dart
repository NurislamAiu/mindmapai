import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:mindmapai/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:mindmapai/features/settings/domain/entities/user_profile.dart';
import 'package:mindmapai/features/settings/domain/entities/user_settings.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_profile.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_user_settings.dart';
import 'package:mindmapai/features/settings/domain/usecases/save_user_settings.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:mindmapai/features/settings/presentation/cubit/settings_state.dart';

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

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void _showFeatureNotImplementedSnackBar(BuildContext context, String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$featureName is not yet implemented.'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop();
              _showFeatureNotImplementedSnackBar(context, 'Account Deletion');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'Settings'),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return const Center(child: CircularProgressIndicator());
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
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w300,
                        ),
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 24),
                  _ProfileSection(userProfile: state.userProfile)
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0),
                  _SettingsGroup(
                    title: 'AI & Credits',
                    children: [
                      _SettingItem(
                        icon: Iconsax.star,
                        label: 'AI Credits',
                        value: '${state.userProfile.credits} remaining',
                        onTap: () => context.push('/upgrade'),
                      ),
                      _SettingItem(icon: Iconsax.document_text, label: 'Version history', onTap: () => _showFeatureNotImplementedSnackBar(context, 'Version history')),
                      _SettingItem(icon: Iconsax.chart, label: 'Usage history', onTap: () => _showFeatureNotImplementedSnackBar(context, 'Usage history')),
                      _SettingItem(
                          icon: Iconsax.crown, label: 'Manage subscription', onTap: () => context.push('/go-pro')),
                    ],
                  ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  _SettingsGroup(
                    title: 'Preferences',
                    children: [
                      _SegmentedSetting<AnalysisDepth>(
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
                      _SegmentedSetting<MindMapLayout>(
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
                      _SettingToggle(
                        icon: Iconsax.document_upload,
                        label: 'Auto-save versions',
                        value: state.userSettings.autoSaveVersions,
                        onChanged: (value) {
                          HapticFeedback.lightImpact();
                          context.read<SettingsCubit>().updateAutoSave(value);
                        }
                      ),
                      _SettingToggle(
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
                  _SettingsGroup(
                    title: 'Data & Privacy',
                    children: [
                      _SettingItem(
                          icon: Iconsax.import, label: 'Export all data', onTap: () => _showFeatureNotImplementedSnackBar(context, 'Export all data')),
                      _SettingItem(
                          icon: Iconsax.trash,
                          label: 'Clear idea history',
                          onTap: () => _showFeatureNotImplementedSnackBar(context, 'Clear idea history')),
                      _SettingItem(
                          icon: Iconsax.shield_tick, label: 'Privacy policy', onTap: () => _showFeatureNotImplementedSnackBar(context, 'Privacy policy')),
                      _SettingItem(
                          icon: Iconsax.document, label: 'Terms of service', onTap: () => _showFeatureNotImplementedSnackBar(context, 'Terms of service')),
                      _SettingItem(
                        icon: Iconsax.user_remove,
                        label: 'Delete account',
                        color: Colors.red.shade600,
                        onTap: () => _showDeleteAccountDialog(context),
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  _SettingsGroup(
                    title: 'Support',
                    children: [
                      _SettingItem(
                          icon: Iconsax.message, label: 'Contact support', onTap: () => context.push('/contact-support')),
                      _SettingItem(
                          icon: Iconsax.edit, label: 'Send feedback', onTap: () => context.push('/send-feedback')),
                      _SettingItem(icon: Iconsax.info_circle, label: 'FAQ', onTap: () => context.push('/help-support')),
                    ],
                  ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.1, end: 0),
                  const _AppInfo()
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

class _ProfileSection extends StatelessWidget {
  final UserProfile userProfile;
  const _ProfileSection({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    final bool isPro = userProfile.subscriptionStatus == SubscriptionStatus.pro;

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: isPro
            ? LinearGradient(
                colors: [Colors.indigo.shade400, Colors.indigo.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isPro ? null : Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: isPro ? null : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: isPro
                ? Colors.indigo.shade200.withOpacity(0.5)
                : Colors.grey.shade300.withOpacity(0.5),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPro ? Colors.white.withOpacity(0.1) : Colors.grey.shade100,
                  border: isPro
                      ? Border.all(color: Colors.white.withOpacity(0.2), width: 1.5)
                      : null,
                ),
                child: Center(
                  child: Text(
                    userProfile.name.substring(0, 1),
                    style: TextStyle(
                      color: isPro ? Colors.white : Colors.grey.shade800,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProfile.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isPro ? Colors.white : Colors.grey.shade900,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userProfile.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isPro
                                ? Colors.white.withOpacity(0.8)
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isPro
                      ? Colors.white.withOpacity(0.15)
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    if (isPro)
                      Icon(Iconsax.crown_1, size: 14, color: Colors.yellow.shade600),
                    if (isPro) const SizedBox(width: 6),
                    Text(
                      isPro ? 'Pro' : 'Free',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPro ? Colors.white : Colors.grey.shade800,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              context.push('/go-pro');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isPro ? Colors.white.withOpacity(0.9) : Colors.indigo.shade500,
              foregroundColor: isPro ? Colors.indigo.shade600 : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: Center(
              child: Text(
                isPro ? 'Manage Subscription' : 'Upgrade to Pro',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: List.generate(children.length, (index) {
                return Column(
                  children: [
                    children[index],
                    if (index < children.length - 1)
                      const Divider(height: 1, indent: 16, endIndent: 16),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final Color? color;

  const _SettingItem(
      {required this.icon, required this.label, this.value, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.grey.shade600, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: color, fontWeight: FontWeight.w400)),
            ),
            if (value != null)
              Text(
                value!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300),
              ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingToggle(
      {required this.icon, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.indigo.shade600,
          ),
        ],
      ),
    );
  }
}

class _SegmentedSetting<T extends Object> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final Map<T, String> options;

  const _SegmentedSetting({
    required this.label,
    required this.icon,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey.shade600, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<T>(
              groupValue: selectedValue,
              onValueChanged: (value) {
                if (value != null) {
                  HapticFeedback.lightImpact();
                  onChanged(value);
                }
              },
              children: {
                for (var option in options.entries)
                  option.key: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(option.value),
                  ),
              },
              thumbColor: Colors.indigo.shade50,
              backgroundColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppInfo extends StatelessWidget {
  const _AppInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Column(
          children: [
            Text('MindMapAI v1.0.0',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300)),
            const SizedBox(height: 4),
            Text('© 2024 MindMapAI. All rights reserved.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}

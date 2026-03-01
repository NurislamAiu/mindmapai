import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/version_history/data/datasources/version_history_local_data_source.dart';
import 'package:mindmapai/features/version_history/data/repositories/version_history_repository_impl.dart';
import 'package:mindmapai/features/version_history/domain/usecases/get_version_history.dart';
import 'package:mindmapai/features/version_history/presentation/cubit/version_history_cubit.dart';
import 'package:mindmapai/features/version_history/presentation/cubit/version_history_state.dart';
import 'package:mindmapai/features/version_history/presentation/widgets/restore_confirmation_dialog.dart';
import 'package:mindmapai/features/version_history/presentation/widgets/version_card.dart';

class VersionHistoryScreen extends StatelessWidget {
  final String ideaTitle;

  const VersionHistoryScreen({super.key, this.ideaTitle = "Meditation App for Professionals"});

  @override
  Widget build(BuildContext context) {
    // В реальном приложении это будет предоставляться через DI (get_it, provider)
    final getVersionHistoryUseCase = GetVersionHistory(
      VersionHistoryRepositoryImpl(
        localDataSource: VersionHistoryLocalDataSourceImpl(),
      ),
    );

    return BlocProvider(
      create: (context) => VersionHistoryCubit(getVersionHistory: getVersionHistoryUseCase)..fetchHistory('idea_id'),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: BlocBuilder<VersionHistoryCubit, VersionHistoryState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: const Color(0xFFFAFAFA).withOpacity(0.85),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: IconButton(
                    icon: const Icon(Iconsax.arrow_left_2, color: Color(0xFF717182)),
                    onPressed: () => context.pop(),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(80.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Version history', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
                          const SizedBox(height: 8),
                          Text('See how your idea evolved over time', style: TextStyle(fontSize: 17, color: Color(0xFF717182), fontWeight: FontWeight.w400)),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.status == VersionHistoryStatus.loading)
                  const SliverFillRemaining(child: Center(child: CupertinoActivityIndicator())),
                if (state.status == VersionHistoryStatus.success)
                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0) {
                             return _buildIdeaContextCard(context, state.versions.length);
                          }
                          final version = state.versions[index - 1];
                          final isCurrent = index == 1;
                          final isSelected = state.selectedVersionId == version.id;
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTimelineIndicator(isCurrent, isSelected),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: VersionCard(
                                      version: version,
                                      isSelected: isSelected,
                                      isCurrent: isCurrent,
                                      onTap: () => context.read<VersionHistoryCubit>().toggleVersionSelection(version.id),
                                      onRestore: () async {
                                        final confirmed = await showRestoreConfirmationDialog(context, version);
                                        if (confirmed == true) {
                                          // Логика восстановления
                                          print('Restoring version: ${version.id}');
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${version.label} restored!')));
                                        }
                                      },
                                      onCompare: () {
                                        print('Comparing version: ${version.id}');
                                        context.push('/compare?previous=${version.id}&current=${state.versions.first.id}');
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: state.versions.length + 1,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildTimelineIndicator(bool isCurrent, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrent ? const Color(0xFF4F46E5) : Colors.white,
          border: Border.all(
            color: isCurrent
                ? const Color(0xFF4F46E5)
                : isSelected
                    ? const Color(0xFFC7D2FE)
                    : const Color(0xFFE9EBEF),
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildIdeaContextCard(BuildContext context, int versionCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('VIEWING HISTORY FOR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF9A9AAA))),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE9EBEF)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEEF2FF), Color(0xFFF5F3FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Iconsax.magic_star, color: Color(0xFF4F46E5), size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ideaTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
                    const SizedBox(height: 4),
                    Text('$versionCount versions', style: const TextStyle(fontSize: 14, color: Color(0xFF717182))),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

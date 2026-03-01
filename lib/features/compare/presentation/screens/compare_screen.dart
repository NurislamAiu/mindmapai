import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/features/compare/data/datasources/compare_local_data_source.dart';
import 'package:mindmapai/features/compare/data/repositories/compare_repository_impl.dart';
import 'package:mindmapai/features/compare/domain/usecases/get_all_versions.dart';
import 'package:mindmapai/features/compare/presentation/cubit/compare_cubit.dart';
import 'package:mindmapai/features/compare/presentation/cubit/compare_state.dart';
import 'package:mindmapai/features/compare/presentation/widgets/changes_summary.dart';
import 'package:mindmapai/features/compare/presentation/widgets/mind_map_view.dart';
import 'package:mindmapai/features/compare/presentation/widgets/version_selector.dart';

class CompareScreen extends StatelessWidget {
  final String ideaTitle;
  final String? previousVersionId;
  final String? currentVersionId;

  const CompareScreen({
    super.key,
    this.ideaTitle = "Meditation App for Professionals",
    this.previousVersionId,
    this.currentVersionId,
  });

  @override
  Widget build(BuildContext context) {
    // В реальном приложении это будет предоставляться через DI
    final getAllVersionsUseCase = GetAllVersions(
      CompareRepositoryImpl(localDataSource: CompareLocalDataSourceImpl()),
    );

    return BlocProvider(
      create: (context) => CompareCubit(getAllVersions: getAllVersionsUseCase)
        ..loadAllVersions(
          'idea_id',
          initialPreviousId: previousVersionId,
          initialCurrentId: currentVersionId,
        ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA).withOpacity(0.85),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_2, color: Color(0xFF717182)),
            onPressed: () => context.pop(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Compare versions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF030213))),
              Text(ideaTitle, style: const TextStyle(fontSize: 14, color: Color(0xFF717182), fontWeight: FontWeight.w400)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Done', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF4F46E5))),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<CompareCubit, CompareState>(
          builder: (context, state) {
            if (state.status == CompareStatus.loading || state.status == CompareStatus.initial) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state.status == CompareStatus.failure) {
              return Center(child: Text(state.error ?? 'Failed to load versions.'));
            }

            final previousVersion = state.previousVersion!;
            final currentVersion = state.currentVersion!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: VersionSelector(
                          label: 'PREVIOUS VERSION',
                          selectedVersion: previousVersion,
                          allVersions: state.allVersions.where((v) => v.id != currentVersion.id).toList(),
                          onVersionSelected: (id) => context.read<CompareCubit>().setPreviousVersion(id),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: VersionSelector(
                          label: 'CURRENT VERSION',
                          selectedVersion: currentVersion,
                          allVersions: state.allVersions.where((v) => v.id != previousVersion.id).toList(),
                          onVersionSelected: (id) => context.read<CompareCubit>().setCurrentVersion(id),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 400,
                    child: Row(
                      children: [
                        Expanded(child: MindMapView(version: previousVersion, isCurrentVersion: false)),
                        const SizedBox(width: 16),
                        Expanded(child: MindMapView(version: currentVersion, isCurrentVersion: true)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ChangesSummary(added: state.addedNodes, modified: state.modifiedNodes, removed: state.removedNodes),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

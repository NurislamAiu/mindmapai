import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/upgrade/data/repositories/upgrade_repository_impl.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_credit_packs_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_cubit.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_state.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_explanation_card.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_pack_item.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_action_buttons.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_shimmer.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/animated_list_item.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_header.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_section_header.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_tertiary_action.dart';


class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = UpgradeRepositoryImpl();
    final useCase = GetCreditPacksUseCase(repository);

    return BlocProvider(
      create: (context) => UpgradeCubit(getCreditPacksUseCase: useCase)..loadCreditPacks(),
      child: const UpgradeView(),
    );
  }
}

class UpgradeView extends StatelessWidget {
  const UpgradeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F7F5),
        appBar: const CommonAppBar(title: 'Get More Credits'),
        body: BlocBuilder<UpgradeCubit, UpgradeState>(
          builder: (context, state) {
            if (state is UpgradeLoading || state is UpgradeInitial) {
              return const UpgradeShimmer();
            }
            if (state is UpgradeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            }
            if (state is UpgradeLoaded) {
              final packs = state.packs;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AnimatedListItem(index: 0, child: UpgradeHeader()),
                        const SizedBox(height: 32),
                        const AnimatedListItem(index: 1, child: CreditExplanationCard()),
                        const SizedBox(height: 32),
                        const AnimatedListItem(index: 2, child: UpgradeSectionHeader()),
                        const SizedBox(height: 24),
                        ...packs.asMap().entries.map((entry) {
                          final index = entry.key;
                          final pack = entry.value;
                          return AnimatedListItem(
                            index: 3 + index,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: CreditPackItem(
                                pack: pack,
                                isSelected: pack.id == state.selectedPack.id,
                                onTap: () =>
                                    context.read<UpgradeCubit>().selectPack(pack),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                        AnimatedListItem(
                          index: 3 + packs.length,
                          child: const UpgradeActionButtons(),
                        ),
                        const SizedBox(height: 24),
                        AnimatedListItem(
                          index: 4 + packs.length,
                          child: const UpgradeTertiaryAction(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

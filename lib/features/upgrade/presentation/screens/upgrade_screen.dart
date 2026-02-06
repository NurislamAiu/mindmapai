import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/upgrade/data/repositories/upgrade_repository_impl.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_credit_packs_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_cubit.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_state.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_explanation_card.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_pack_item.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_action_buttons.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_header_symbol.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: const Color(0xFFF8F7F5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<UpgradeCubit, UpgradeState>(
          builder: (context, state) {
            // --- Loading and Error States ---
            if (state is UpgradeLoading || state is UpgradeInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UpgradeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(state.message, textAlign: TextAlign.center),
                ),
              );
            }

            // --- Loaded State ---
            if (state is UpgradeLoaded) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const UpgradeHeaderSymbol(),
                            const SizedBox(height: 24),
                            Text(
                              'Go deeper with MindMapAI',
                              textAlign: TextAlign.center,
                              style: textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade900,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "You've used your free AI analyses. Choose how you'd like to continue exploring your ideas.",
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.grey.shade600,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            const CreditExplanationCard(),
                            const SizedBox(height: 32),
                            // Section Header
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                'Choose a credit pack',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24), // Increased space for the badge
                            // List of credit packs
                            ...List.generate(state.packs.length, (index) {
                              final pack = state.packs[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: CreditPackItem(
                                  pack: pack,
                                  isSelected: pack.id == state.selectedPack.id,
                                  onTap: () => context.read<UpgradeCubit>().selectPack(pack),
                                ),
                              );
                            }),
                            const SizedBox(height: 16),
                            // Action Buttons
                            const UpgradeActionButtons(),
                            const SizedBox(height: 24),
                            // Tertiary Action
                            Center(
                              child: TextButton(
                                onPressed: () { /* TODO: Handle continue */ },
                                child: Text(
                                  'Continue with limited access',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

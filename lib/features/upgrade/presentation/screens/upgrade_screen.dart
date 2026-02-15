import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/upgrade/data/repositories/upgrade_repository_impl.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_credit_packs_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_cubit.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/upgrade_state.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_explanation_card.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/credit_pack_item.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/upgrade_action_buttons.dart';

class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This setup is for demonstration. In a real app, you'd use a dependency injection framework.
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
        body: BlocBuilder<UpgradeCubit, UpgradeState>(
          builder: (context, state) {
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
            if (state is UpgradeLoaded) {
              return Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 64, 24, 40),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const _Header(),
                              const SizedBox(height: 32),
                              const CreditExplanationCard(),
                              const SizedBox(height: 32),
                              const _SectionHeader(),
                              const SizedBox(height: 24),
                              ...state.packs.map((pack) => Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: CreditPackItem(
                                      pack: pack,
                                      isSelected: pack.id == state.selectedPack.id,
                                      onTap: () => context.read<UpgradeCubit>().selectPack(pack),
                                    ),
                                  )),
                              const SizedBox(height: 16),
                              const UpgradeActionButtons(),
                              const SizedBox(height: 24),
                              const _TertiaryAction(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const _BackButton(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgPicture.asset(
          'assets/icon/icon_svg.svg',
          height: 120,
          width: 120,
        ),
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
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        'Choose a credit pack',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
      ),
    );
  }
}

class _TertiaryAction extends StatelessWidget {
  const _TertiaryAction();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          /* TODO: Handle continue with limited access */
        },
        child: Text(
          'Continue with limited access',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
                decoration: TextDecoration.underline,
              ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
          onPressed: () => context.pop(),
        ),
      ),
    );
  }
}

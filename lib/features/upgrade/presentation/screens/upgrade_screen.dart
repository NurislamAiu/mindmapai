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
              final packs = state.packs;
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AnimatedListItem(index: 0, child: const _Header()),
                        const SizedBox(height: 32),
                        AnimatedListItem(index: 1, child: const CreditExplanationCard()),
                        const SizedBox(height: 32),
                        AnimatedListItem(index: 2, child: const _SectionHeader()),
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
                          child: const _TertiaryAction(),
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Image.asset(
          'assets/icon/icon.png',
          height: 120,
          width: 120,
        ),
        const SizedBox(height: 24),
        Text(
          'Go deeper with MINDRA',
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

class AnimatedListItem extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

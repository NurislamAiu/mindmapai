import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/upgrade/data/repositories/upgrade_repository_impl.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_pro_plans_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/go_pro_cubit.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/go_pro_state.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/feature_list_item.dart';
import 'package:mindmapai/features/upgrade/presentation/widgets/plan_selection_card.dart';

class GoProScreen extends StatelessWidget {
  const GoProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = UpgradeRepositoryImpl();
    final useCase = GetProPlansUseCase(repository);

    return BlocProvider(
      create: (context) => GoProCubit(getProPlansUseCase: useCase)..loadPlans(),
      child: const GoProView(),
    );
  }
}

class GoProView extends StatelessWidget {
  const GoProView({super.key});

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
        body: BlocBuilder<GoProCubit, GoProState>(
          builder: (context, state) {
            if (state is GoProLoading || state is GoProInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is GoProError) {
              return Center(child: Text(state.message));
            }
            if (state is GoProLoaded) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 64, 24, 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _Header(),
                        const SizedBox(height: 32),

                        ...state.plans.map(
                          (plan) => Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: PlanSelectionCard(
                              plan: plan,
                              isSelected: state.selectedPlan.id == plan.id,
                              onTap: () =>
                                  context.read<GoProCubit>().selectPlan(plan),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          child: _FeaturesList(
                            key: ValueKey(state.selectedPlan.id),
                            features: state.selectedPlan.features,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _StickyFooter(selectedPlan: state.selectedPlan),

                  _BackButton(),
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
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.shade100.withOpacity(0.4),
                blurRadius: 25,
              ),
            ],
          ),
          child: Icon(
            Icons.workspace_premium_outlined,
            color: Colors.indigo.shade500,
            size: 40,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Unlock Your Full Potential',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Get monthly credits and access all premium features to level up your thinking.',
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

class _FeaturesList extends StatelessWidget {
  final List<String> features;

  const _FeaturesList({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: Colors.grey.shade200.withOpacity(0.8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pro features include:',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FeatureListItem(text: feature),
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyFooter extends StatelessWidget {
  final ProPlanEntity selectedPlan;

  const _StickyFooter({required this.selectedPlan});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: BoxDecoration(
          color: Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200.withOpacity(1),
              blurRadius: 30.0,
              spreadRadius: 15.0,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                /* TODO: Implement purchase logic */
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                elevation: 0,
              ),
              child: Text(
                'Subscribe to ${selectedPlan.title} Plan',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                /* TODO: Implement restore purchases */
              },
              child: Text(
                'Restore Purchases',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

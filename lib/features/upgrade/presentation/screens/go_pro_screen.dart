import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmapai/features/upgrade/data/repositories/upgrade_repository_impl.dart';
import 'package:mindmapai/features/upgrade/domain/entities/pro_plan_entity.dart';
import 'package:mindmapai/features/upgrade/domain/usecases/get_pro_plans_usecase.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/go_pro_cubit.dart';
import 'package:mindmapai/features/upgrade/presentation/cubit/go_pro_state.dart';

class GoProScreen extends StatelessWidget {
  const GoProScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This setup is for demonstration. In a real app, you'd use a dependency injection framework.
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
                    padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _Header(),
                        const SizedBox(height: 32),
                        const _ValueExplanation(),
                        const SizedBox(height: 24),
                        _ProPlanCard(plan: state.selectedPlan),
                        const SizedBox(height: 32),
                        _ActionButtons(selectedPlan: state.selectedPlan),
                      ],
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
        Text(
          'Go Pro',
          textAlign: TextAlign.center,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade900,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'For deeper, ongoing idea development',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w300,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ValueExplanation extends StatelessWidget {
  const _ValueExplanation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        'Pro gives you monthly AI credits and deeper insights, so you can continuously refine and grow your ideas.',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
      ),
    );
  }
}

class _ProPlanCard extends StatelessWidget {
  final ProPlanEntity plan;

  const _ProPlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: Colors.indigo.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.shade50.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.title,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                plan.price,
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade900,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                plan.billingCycle,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...plan.features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _FeatureListItem(text: feature),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureListItem extends StatelessWidget {
  final String text;

  const _FeatureListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(top: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo.shade100,
          ),
          child: Icon(
            Icons.check,
            size: 14,
            color: Colors.indigo.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.grey.shade700, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final ProPlanEntity selectedPlan;
  const _ActionButtons({required this.selectedPlan});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            /* TODO: Implement purchase logic */
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade600,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            elevation: 0,
          ),
          child: Text(
            'Start Pro',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Cancel anytime',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            /* TODO: Implement restore purchases */
          },
          child: Text(
            'Restore Purchases',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

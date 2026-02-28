import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/settings/data/repositories/privacy_policy_repository_impl.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_privacy_policy_usecase.dart';
import 'package:mindmapai/features/settings/presentation/cubit/privacy_policy_cubit.dart';
import 'package:mindmapai/features/settings/presentation/cubit/privacy_policy_state.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simplified DI, in a real app, use get_it or provider
    final repository = PrivacyPolicyRepositoryImpl();
    final useCase = GetPrivacyPolicyUseCase(repository);

    return BlocProvider(
      create: (context) => PrivacyPolicyCubit(getPrivacyPolicyUseCase: useCase)..fetchPrivacyPolicy(),
      child: const PrivacyPolicyView(),
    );
  }
}

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'Privacy Policy'),
      body: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (context, state) {
          if (state is PrivacyPolicyLoading || state is PrivacyPolicyInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PrivacyPolicyError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          if (state is PrivacyPolicyLoaded) {
            return Markdown(
              data: state.markdownData,
              padding: const EdgeInsets.all(24.0),
              styleSheet: MarkdownStyleSheet(
                p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey.shade700,
                      height: 1.6,
                      fontWeight: FontWeight.w300,
                    ),
                h1: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                h2: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/settings/data/repositories/terms_of_service_repository_impl.dart';
import 'package:mindmapai/features/settings/domain/usecases/get_terms_of_service_usecase.dart';
import 'package:mindmapai/features/settings/presentation/cubit/terms_of_service_cubit.dart';
import 'package:mindmapai/features/settings/presentation/cubit/terms_of_service_state.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simplified DI
    final repository = TermsOfServiceRepositoryImpl();
    final useCase = GetTermsOfServiceUseCase(repository);

    return BlocProvider(
      create: (context) => TermsOfServiceCubit(getTermsOfServiceUseCase: useCase)..fetchTermsOfService(),
      child: const TermsOfServiceView(),
    );
  }
}

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'Terms of Service'),
      body: BlocBuilder<TermsOfServiceCubit, TermsOfServiceState>(
        builder: (context, state) {
          if (state is TermsOfServiceLoading || state is TermsOfServiceInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TermsOfServiceError) {
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
          if (state is TermsOfServiceLoaded) {
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

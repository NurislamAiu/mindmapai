import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mindmapai/features/help_support/data/datasources/help_support_local_data_source.dart';
import 'package:mindmapai/features/help_support/data/repositories/help_support_repository_impl.dart';
import 'package:mindmapai/features/help_support/domain/usecases/get_help_support_data.dart';
import 'package:mindmapai/features/help_support/presentation/cubit/help_support_cubit.dart';
import 'package:mindmapai/features/help_support/presentation/cubit/help_support_state.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/contact_button.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/faq_accordion.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/legal_button.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/quick_help_card_widget.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF8F7F5),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => HelpSupportCubit(
          getHelpSupportData: GetHelpSupportData(
            HelpSupportRepositoryImpl(
              localDataSource: HelpSupportLocalDataSourceImpl(),
            ),
          ),
        )..fetchData(),
        child: BlocBuilder<HelpSupportCubit, HelpSupportState>(
          builder: (context, state) {
            if (state is HelpSupportLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HelpSupportError) {
              return Center(child: Text(state.message));
            }
            if (state is HelpSupportLoaded) {
              final legalButtons = state.data.legalItems
                  .map((item) => LegalButton(item: item))
                  .toList();
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'We\'re here to help you think clearly and confidently.',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w300),
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),
                    const SizedBox(height: 32),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                      ),
                      itemCount: state.data.quickHelpCards.length,
                      itemBuilder: (context, index) {
                        return QuickHelpCardWidget(
                                card: state.data.quickHelpCards[index])
                            .animate()
                            .fadeIn(
                                delay: (200 * (index * 0.5)).ms,
                                duration: 500.ms)
                            .slideY(begin: 0.2);
                      },
                    ),
                    const SizedBox(height: 32),
                    const _SectionHeader(title: 'Frequently Asked Questions'),
                    const SizedBox(height: 16),
                    FaqAccordion(faqItems: state.data.faqItems)
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 500.ms)
                        .slideY(begin: 0.2),
                    const SizedBox(height: 32),
                    const _SectionHeader(title: 'Get in Touch'),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data.contactItems.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return ContactButton(
                                item: state.data.contactItems[index])
                            .animate()
                            .fadeIn(
                                delay: (500 + 100 * index).ms,
                                duration: 500.ms)
                            .slideY(begin: 0.2);
                      },
                    ),
                    const SizedBox(height: 32),
                    const _SectionHeader(title: 'Legal'),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                         boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200.withOpacity(0.8),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          for (int i = 0; i < legalButtons.length; i++) ...[
                            legalButtons[i],
                            if (i < legalButtons.length - 1)
                              Divider(
                                  height: 1,
                                  color: Colors.grey.shade100,
                                  indent: 16,
                                  endIndent: 16),
                          ]
                        ],
                      ),
                    ).animate()
                        .fadeIn(delay: 800.ms, duration: 500.ms)
                        .slideY(begin: 0.2),
                    const SizedBox(height: 48),
                  ],
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

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF1D2939),
      ),
    );
  }
}

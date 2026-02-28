import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mindmapai/common/widgets/common_app_bar.dart';
import 'package:mindmapai/features/help_support/data/datasources/help_support_local_data_source.dart';
import 'package:mindmapai/features/help_support/data/repositories/help_support_repository_impl.dart';
import 'package:mindmapai/features/help_support/domain/usecases/get_help_support_data.dart';
import 'package:mindmapai/features/help_support/presentation/cubit/help_support_cubit.dart';
import 'package:mindmapai/features/help_support/presentation/cubit/help_support_state.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/contact_button.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/faq_accordion.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/help_support_item.dart';
import 'package:mindmapai/features/help_support/presentation/widgets/quick_help_card_widget.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: const CommonAppBar(title: 'Help & Support'),
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
            if (state is HelpSupportError) {
              return Center(child: Text(state.message));
            }
            if (state is HelpSupportLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      "We're here to help you think clearly and confidently.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    const SizedBox(height: 32),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.95,
                      ),
                      itemCount: state.data.quickHelpCards.length,
                      itemBuilder: (context, index) {
                        return QuickHelpCardWidget(card: state.data.quickHelpCards[index]);
                      },
                    ),
                    const SizedBox(height: 32),
                    const _SectionHeader(title: 'Frequently Asked Questions'),
                    const SizedBox(height: 16),
                    FaqAccordion(faqItems: state.data.faqItems),
                    const SizedBox(height: 32),
                    const _SectionHeader(title: 'Get in Touch'),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.data.contactItems.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return ContactButton(item: state.data.contactItems[index]);
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
                          HelpSupportItem(
                            icon: Iconsax.shield_tick,
                            title: 'Privacy Policy',
                            path: '/privacy-policy',
                          ),
                          Divider(height: 1, color: Colors.grey.shade100, indent: 16, endIndent: 16),
                          HelpSupportItem(
                            icon: Iconsax.document,
                            title: 'Terms of Service',
                            path: '/terms-of-service',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
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

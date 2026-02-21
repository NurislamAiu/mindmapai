import 'package:flutter/material.dart';
import 'package:mindmapai/common/widgets/provider_helpers.dart';
import '../../data/repositories/explore_repository_impl.dart';
import '../../domain/usecases/get_explore_data.dart';
import '../providers/explore_provider.dart';
import '../widgets/explore_recommended_template_card.dart';
import '../widgets/explore_template_list_item.dart';
import '../widgets/explore_why_use_templates_card.dart';


class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DI
    final exploreRepository = ExploreRepositoryImpl();
    final getExploreData = GetExploreData(exploreRepository);

    return ChangeNotifierProvider(
      create: (context) => ExploreProvider(getExploreData: getExploreData)..fetchData(),
      child: Consumer<ExploreProvider>(
        builder: (context, provider, child) {
          final textTheme = Theme.of(context).textTheme;
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24.0),
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Explore', style: textTheme.headlineSmall),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Start faster with AI-powered templates',
                        style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    
                    // Body
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (provider.error != null)
                      Center(child: Text(provider.error!))
                    else
                      _buildContent(provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildContent(ExploreProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (provider.recommendedTemplate != null)
          RecommendedTemplateCard(template: provider.recommendedTemplate!),
        
        const SizedBox(height: 32.0),
        
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text('Popular templates', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12.0),
        
        ListView.separated(
          itemCount: provider.popularTemplates.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TemplateListItem(template: provider.popularTemplates[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
        
        const SizedBox(height: 12.0),
        
        const WhyUseTemplatesCard(),

        const SizedBox(height: 50), // Padding for nav bar
      ],
    );
  }
}

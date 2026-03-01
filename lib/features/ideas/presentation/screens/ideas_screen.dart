import 'package:flutter/material.dart';
import 'package:mindmapai/common/widgets/provider_helpers.dart';
import '../../../home/data/repositories/home_repository_impl.dart';
import '../../../home/domain/usecases/get_all_ideas.dart';
import '../../../home/presentation/widgets/home_idea_list_item.dart';
import '../providers/ideas_provider.dart';
import '../widgets/ideas_filter_tabs.dart';
import '../widgets/ideas_shimmer_list.dart';

class IdeasScreen extends StatelessWidget {
  const IdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ideasRepository = HomeRepositoryImpl();
    final getAllIdeas = GetAllIdeas(ideasRepository);

    return ChangeNotifierProvider(
      create: (context) => IdeasProvider(getAllIdeas: getAllIdeas)..fetchIdeas(),
      child: Consumer<IdeasProvider>(
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
                      child: Text('Ideas', style: textTheme.headlineSmall),
                    ),
                    const SizedBox(height: 4.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'All your thoughts, structured and ready',
                        style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    // Filter Tabs
                    IdeasFilterTabs(
                      activeFilter: provider.activeFilter,
                      onFilterChanged: provider.setFilter,
                    ),
                    const SizedBox(height: 24.0),
                    // Content
                    if (provider.isLoading)
                      const IdeasShimmerList()
                    else if (provider.error != null)
                      Center(child: Text(provider.error!))
                    else
                      ListView.separated(
                        itemCount: provider.filteredIdeas.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return HomeIdeaListItem(
                            idea: provider.filteredIdeas[index],
                            index: index,
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                      ),
                    const SizedBox(height: 120), // Padding for nav bar
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

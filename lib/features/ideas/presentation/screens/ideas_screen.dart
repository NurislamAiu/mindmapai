import 'package:flutter/material.dart';
import '../../../home/data/repositories/home_repository_impl.dart';
import '../../../home/domain/usecases/get_all_ideas.dart';
import '../../../home/presentation/screens/home_screen.dart'; // For Provider
import '../../../home/presentation/widgets/home_idea_list_item.dart';
import '../providers/ideas_provider.dart';

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
                    _FilterTabs(
                      activeFilter: provider.activeFilter,
                      onFilterChanged: provider.setFilter,
                    ),
                    const SizedBox(height: 24.0),
                    // Content
                    if (provider.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (provider.error != null)
                      Center(child: Text(provider.error!))
                    else
                      ListView.separated(
                        itemCount: provider.filteredIdeas.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IdeaListItem(idea: provider.filteredIdeas[index]);
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

class _FilterTabs extends StatelessWidget {
  final IdeaFilter activeFilter;
  final ValueChanged<IdeaFilter> onFilterChanged;

  const _FilterTabs({required this.activeFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FilterButton(
          label: 'All',
          isActive: activeFilter == IdeaFilter.All,
          onTap: () => onFilterChanged(IdeaFilter.All),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Analyzed',
          isActive: activeFilter == IdeaFilter.Analyzed,
          onTap: () => onFilterChanged(IdeaFilter.Analyzed),
        ),
        const SizedBox(width: 8),
        _FilterButton(
          label: 'Drafts',
          isActive: activeFilter == IdeaFilter.Drafts,
          onTap: () => onFilterChanged(IdeaFilter.Drafts),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Colors.grey[900] : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.grey[600],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        elevation: 0,
        side: isActive ? BorderSide.none : BorderSide(color: Colors.grey.shade200)
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

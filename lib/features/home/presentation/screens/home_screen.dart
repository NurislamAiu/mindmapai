import 'package:flutter/material.dart';
import '../../../main/presentation/screens/main_screen.dart'; // For Provider
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/home_screen_data.dart';
import '../../domain/usecases/get_home_screen_data.dart';
import '../providers/home_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/focus_card.dart';
import '../widgets/primary_action_card.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/recent_ideas_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Composition Root: In a larger app, this would be handled by a DI container like get_it.
    // For this feature's scope, creating dependencies here is a clean, localized approach.
    final homeRepository = HomeRepositoryImpl();
    final getHomeScreenData = GetHomeScreenData(homeRepository);

    return ChangeNotifierProvider(
      create: (context) =>
          HomeProvider(getHomeScreenData: getHomeScreenData)..fetchData(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            // To keep the UI clean, we remove the AppBar for now.
            // The header is part of the scrollable content.
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: _buildBody(context, provider),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeProvider provider) {
    switch (provider.state) {
      case HomeState.loading:
      case HomeState.initial:
        return const Center(child: CircularProgressIndicator());
      case HomeState.error:
        return Center(child: Text(provider.errorMessage ?? 'An error occurred'));
      case HomeState.loaded:
        return _buildContentLoaded(context, provider.data!);
    }
  }

  Widget _buildContentLoaded(BuildContext context, HomeScreenData data) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Welcome back', style: textTheme.headlineSmall),
          ),
          const SizedBox(height: 4.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'What would you like to think through today?',
              style: textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 24.0),

          // Cards and Actions
          const PrimaryActionCard(),
          const SizedBox(height: 16.0),
          FocusCard(lastIdea: data.lastIdea),
          const SizedBox(height: 16.0),
          const QuickActionsRow(),
          const SizedBox(height: 32.0),

          // Conditional Content
          if (data.hasIdeas)
            RecentIdeasSection(ideas: data.recentIdeas)
          else
            const EmptyState(),
          
          // Footer
          const SizedBox(height: 16.0),
          Center(
            child: Text(
              'You have ${data.creditsRemaining} AI credits',
              style: textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 120), // Bottom padding for floating nav bar
        ],
      ),
    );
  }
}

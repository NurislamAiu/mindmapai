import 'package:flutter/material.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/home_screen_data.dart';
import '../../domain/usecases/get_home_screen_data.dart';
import '../providers/home_provider.dart';
import '../widgets/home_credits_indicator.dart';
import '../widgets/home_empty_state.dart';
import '../widgets/home_focus_card.dart';
import '../widgets/home_primary_action_card.dart';
import '../widgets/home_quick_actions_row.dart';
import '../widgets/home_recent_ideas_section.dart';

// --- Вспомогательные виджеты для Provider ---
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final T Function(BuildContext context) create;
  final Widget child;

  const ChangeNotifierProvider({
    super.key,
    required this.create,
    required this.child,
  });

  static T of<T extends ChangeNotifier>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_InheritedProvider<T>>()!.notifier!;
  }

  @override
  State<ChangeNotifierProvider> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {
  late final T notifier;

  @override
  void initState() {
    super.initState();
    notifier = widget.create(context);
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return _InheritedProvider<T>(
      notifier: notifier,
      child: widget.child,
    );
  }
}

class _InheritedProvider<T extends ChangeNotifier> extends InheritedWidget {
  final T? notifier;

  const _InheritedProvider({
    required Widget child,
    this.notifier,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_InheritedProvider<T> oldWidget) {
    return notifier != oldWidget.notifier;
  }
}

class Consumer<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T provider, Widget? child) builder;
  final Widget? child;
  
  const Consumer({
    super.key,
    required this.builder,
    this.child,
  });

  @override
  State<Consumer<T>> createState() => _ConsumerState<T>();
}

class _ConsumerState<T extends ChangeNotifier> extends State<Consumer<T>> {
  late T provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = ChangeNotifierProvider.of<T>(context);
    provider.addListener(_listener);
  }

  @override
  void dispose() {
    provider.removeListener(_listener);
    super.dispose();
  }

  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      provider,
      widget.child,
    );
  }
}
// --- Конец вспомогательных виджетов ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeRepository = HomeRepositoryImpl();
    final getHomeScreenData = GetHomeScreenData(homeRepository);

    return ChangeNotifierProvider(
      create: (context) =>
          HomeProvider(getHomeScreenData: getHomeScreenData)..fetchData(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
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
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcome back', style: textTheme.headlineSmall),
                CreditsIndicator(creditCount: data.creditsRemaining),
              ],
            ),
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
          const PrimaryActionCard(),
          const SizedBox(height: 16.0),
          FocusCard(lastIdea: data.lastIdea),
          const SizedBox(height: 16.0),
          const QuickActionsRow(),
          const SizedBox(height: 32.0),
          if (data.hasIdeas)
            RecentIdeasSection(ideas: data.recentIdeas)
          else
            const EmptyState(),
          const SizedBox(height: 120), // Bottom padding for floating nav bar
        ],
      ),
    );
  }
}

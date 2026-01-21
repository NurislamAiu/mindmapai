import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../providers/main_provider.dart';
import '../widgets/bottom_nav_bar.dart';

// Dummy Provider implementation for compilation.
// In a real app, you would use the provider package.
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

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // Pages for each tab, with HomeScreen now in the first position.
  final List<Widget> _pages = const [
    HomeScreen(),
    _PlaceholderPage(title: 'Ideas', color: Colors.green),
    _PlaceholderPage(title: 'Explore', color: Colors.blue),
    _PlaceholderPage(title: 'Profile', color: Colors.orange),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainProvider(),
      child: Consumer<MainProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            extendBody: true, // Allows the body to go behind the nav bar
            bottomNavigationBar: BottomNavBar(
              activeTab: provider.activeTab,
              onTabChange: provider.onTabChanged,
            ),
            body: PageView(
              controller: provider.pageController,
              onPageChanged: provider.onPageChanged,
              // Prevent scrolling for now to use the bottom nav bar exclusively
              physics: const NeverScrollableScrollPhysics(), 
              children: _pages,
            ),
          );
        },
      ),
    );
  }
}

// Simple placeholder widget for demonstrating page switching
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final Color color;
  const _PlaceholderPage({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.withOpacity(0.1),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/nav_item.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  // navigationShell - это виджет от GoRouter, который содержит текущую страницу.
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  // Преобразуем текущий индекс из GoRouter в наш NavItem
  NavItem _indexToNavItem(int index) {
    return NavItem.values[index];
  }

  void _onTabChanged(BuildContext context, int index) {
    // Используем navigationShell для перехода на нужную вкладку,
    // не теряя при этом состояние других вкладок.
    navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell, // Телом экрана теперь является сам navigationShell
      bottomNavigationBar: BottomNavBar(
        activeTab: _indexToNavItem(navigationShell.currentIndex),
        onTabChange: (item) => _onTabChanged(context, item.index),
      ),
    );
  }
}

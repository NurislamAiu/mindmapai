import 'package:flutter/material.dart';
import '../../domain/entities/nav_item.dart';

class MainProvider with ChangeNotifier {
  final PageController pageController = PageController();
  NavItem _activeTab = NavItem.home;

  NavItem get activeTab => _activeTab;

  void onTabChanged(NavItem tab) {
    if (_activeTab == tab) return;

    _activeTab = tab;
    // Animate to the new page
    pageController.animateToPage(
      tab.index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
    notifyListeners();
  }

  void onPageChanged(int pageIndex) {
    if (_activeTab.index == pageIndex) return;
    
    _activeTab = NavItem.values[pageIndex];
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

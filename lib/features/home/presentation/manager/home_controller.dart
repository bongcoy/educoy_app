import 'package:educoy_app/core/common/manager/tab_navigator.dart';
import 'package:educoy_app/core/common/views/persistent_page.dart';
import 'package:educoy_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const Placeholder())),
      child: const PersistentPage(),
    ),
    ChangeNotifierProvider(
      create: (_) => TabNavigator(TabItem(child: const ProfilePage())),
      child: const PersistentPage(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 3;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}

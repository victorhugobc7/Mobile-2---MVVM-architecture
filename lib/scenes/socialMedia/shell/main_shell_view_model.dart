import 'package:flutter/material.dart';
import '../../../resources/shared/app_coordinator.dart';
import '../../../DesignSystem/Components/NavItem/nav_item_view_model.dart';

class MainShellViewModel extends ChangeNotifier {
  final AppCoordinator coordinator;
  final List<Widget> pages;
  
  int _currentIndex = 0;

  late NavItemViewModel homeNavViewModel;
  late NavItemViewModel networkNavViewModel;
  late NavItemViewModel postNavViewModel;
  late NavItemViewModel notificationsNavViewModel;
  late NavItemViewModel jobsNavViewModel;

  MainShellViewModel({
    required this.coordinator,
    required this.pages,
  }) {
    homeNavViewModel = NavItemViewModel(
      icon: Icons.home_filled,
      label: 'Início',
      isActive: _currentIndex == 0,
      onTap: () => setCurrentIndex(0),
    );

    networkNavViewModel = NavItemViewModel(
      icon: Icons.people_outline,
      label: 'Rede',
      isActive: _currentIndex == 1,
      onTap: () => setCurrentIndex(1),
    );

    postNavViewModel = NavItemViewModel(
      icon: Icons.add_box_outlined,
      label: 'Publicar',
      onTap: goToCreatePost,
    );

    notificationsNavViewModel = NavItemViewModel(
      icon: Icons.notifications_outlined,
      label: 'Notificações',
      isActive: _currentIndex == 2,
      onTap: () => setCurrentIndex(2),
    );

    jobsNavViewModel = NavItemViewModel(
      icon: Icons.work_outline,
      label: 'Vagas',
      isActive: _currentIndex == 3,
      onTap: () => setCurrentIndex(3),
    );
  }

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    _recreateNavItems();
    notifyListeners();
  }

  void _recreateNavItems() {
    homeNavViewModel = NavItemViewModel(
      icon: Icons.home_filled,
      label: 'Início',
      isActive: _currentIndex == 0,
      onTap: () => setCurrentIndex(0),
    );

    networkNavViewModel = NavItemViewModel(
      icon: Icons.people_outline,
      label: 'Rede',
      isActive: _currentIndex == 1,
      onTap: () => setCurrentIndex(1),
    );

    notificationsNavViewModel = NavItemViewModel(
      icon: Icons.notifications_outlined,
      label: 'Notificações',
      isActive: _currentIndex == 2,
      onTap: () => setCurrentIndex(2),
    );

    jobsNavViewModel = NavItemViewModel(
      icon: Icons.work_outline,
      label: 'Vagas',
      isActive: _currentIndex == 3,
      onTap: () => setCurrentIndex(3),
    );
  }

  void goToCreatePost() {
    coordinator.goToCreatePost();
  }
}

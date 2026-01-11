import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/NavItem/nav_item.dart';
import 'main_shell_view_model.dart';

class MainShellView extends StatelessWidget {
  final MainShellViewModel viewModel;

  const MainShellView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MainShellViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            body: IndexedStack(
              index: vm.currentIndex,
              children: vm.pages,
            ),
            bottomNavigationBar: _buildBottomNav(vm),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(MainShellViewModel vm) {
    return Container(
      decoration: const BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: gray_300)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: doubleXS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem.instantiate(viewModel: vm.homeNavViewModel),
              NavItem.instantiate(viewModel: vm.networkNavViewModel),
              NavItem.instantiate(viewModel: vm.postNavViewModel),
              NavItem.instantiate(viewModel: vm.notificationsNavViewModel),
              NavItem.instantiate(viewModel: vm.jobsNavViewModel),
            ],
          ),
        ),
      ),
    );
  }
}

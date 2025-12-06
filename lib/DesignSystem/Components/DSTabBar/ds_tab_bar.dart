import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'ds_tab_bar_view_model.dart';

class DSTabBar extends StatelessWidget {
  final DSTabBarViewModel viewModel;

  const DSTabBar._({required this.viewModel});

  factory DSTabBar.instantiate({required DSTabBarViewModel viewModel}) {
    return DSTabBar._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DSTabBarViewModel>(
        builder: (context, vm, child) {
          return Container(
            color: white,
            padding: EdgeInsets.symmetric(horizontal: small),
            child: Row(
              children: List.generate(vm.tabs.length, (index) {
                final isSelected = vm.selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => vm.selectTab(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: extraSmall),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? blue_500 : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          vm.tabs[index],
                          style: labelTextStyle.copyWith(
                            color: isSelected ? blue_500 : gray_600,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

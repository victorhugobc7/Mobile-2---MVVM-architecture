import 'package:flutter/material.dart';
import '../../shared/colors.dart';
import '../../shared/styles.dart';
import '../../shared/spacing.dart';
import 'nav_item_view_model.dart';

class NavItem extends StatelessWidget {
  final NavItemViewModel viewModel;

  const NavItem._({required this.viewModel});

  static Widget instantiate({required NavItemViewModel viewModel}) {
    return NavItem._(viewModel: viewModel);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: viewModel.onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                viewModel.icon,
                color: viewModel.isActive ? primaryInk : gray_600,
                size: 24,
              ),
              if (viewModel.badgeCount != null && viewModel.badgeCount! > 0)
                Positioned(
                  right: -8,
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: tripleXS, vertical: 1),
                    decoration: BoxDecoration(
                      color: red_error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      viewModel.badgeCount! > 99 ? '99+' : '${viewModel.badgeCount}',
                      style: label2Regular.copyWith(
                        color: white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: tripleXS),
          Text(
            viewModel.label,
            style: label2Regular.copyWith(
              color: viewModel.isActive ? primaryInk : gray_600,
            ),
          ),
        ],
      ),
    );
  }
}

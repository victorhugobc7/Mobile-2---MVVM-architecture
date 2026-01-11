import 'package:flutter/material.dart';
import 'tab_view_model.dart';
import '../../../resources/shared/colors.dart';
import '../../../../resources/shared/fonts.dart';


class TabComponent extends StatefulWidget {
  final TabViewModel tabViewModel;

  const TabComponent._({required this.tabViewModel});

  @override
  State<TabComponent> createState() => _TabComponentState();

  static Widget instantiate({required TabViewModel tabViewModel}) {
    return TabComponent._(tabViewModel: tabViewModel);
  }
}

class _TabComponentState extends State<TabComponent>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: widget.tabViewModel.tabs.length,
        vsync: this,
        initialIndex: widget.tabViewModel.initialIndex);
    tabController.addListener(handleTabChange);
  }

  void handleTabChange() {
    if (tabController.indexIsChanging) {
      widget.tabViewModel.onIndexChanged?.call(tabController.index);
    }
  }

  @override
  void dispose() {
    tabController.removeListener(handleTabChange);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: widget.tabViewModel.tabs,
          indicatorColor: yellow_marigold,
          labelStyle: TextStyle(
            color: primaryInk,
            fontWeight: FontWeight.bold,
            fontFamily: primaryFont,
          ),
          unselectedLabelStyle: TextStyle(
            color: primaryInk,
            fontFamily: primaryFont,
          ),
        ),
      ],
    );
  }
}

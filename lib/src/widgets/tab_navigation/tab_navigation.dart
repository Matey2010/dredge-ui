import 'package:dredge_ui/src/models/select_option.dart';
import 'package:dredge_ui/src/widgets/tab_navigation/default_tab_navigation_item.dart';
import 'package:dredge_ui/utils.dart';
import 'package:flutter/widgets.dart';

class TabNavigation extends StatelessWidget {
  final List<SelectOption> tabs;
  final dynamic selectedTab;
  final void Function(dynamic) onSelectTab;
  final String? translationSection;
  final Widget Function({
    required int index,
    required SelectOption tab,
    required bool isActive,
    required void Function(dynamic) onSelect,
  })?
  itemBuilder;

  const TabNavigation({
    required this.tabs,
    required this.selectedTab,
    required this.onSelectTab,
    this.translationSection,
    this.itemBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...tabs.mapIndexed(
          (index, tab) => Expanded(
            key: ValueKey(tab.text),
            child:
                itemBuilder?.call(
                  index: index,
                  tab: tab,
                  isActive: tab.value == selectedTab,
                  onSelect: onSelectTab,
                ) ??
                DefaultTabNavigationItem(
                  tabIndex: index,
                  tab: tab,
                  isActive: tab.value == selectedTab,
                  onSelect: onSelectTab,
                  translationSection: translationSection,
                ),
          ),
        ),
      ],
    );
  }
}

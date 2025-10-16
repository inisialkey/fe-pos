import 'package:flutter/material.dart';
import 'package:pos/core/core.dart';

class TabMenu extends StatefulWidget {
  final List<String> title;
  final int initialTabIndex;
  final List<Widget> tabViews;

  const TabMenu({
    required this.title,
    required this.initialTabIndex,
    required this.tabViews,
    super.key,
  });

  @override
  State<TabMenu> createState() => _TabMenuState();
}

class _TabMenuState extends State<TabMenu> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: List.generate(
          widget.title.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimens.space14),
              margin: EdgeInsets.only(right: Dimens.space30 + Dimens.space2),
              decoration: BoxDecoration(
                border: _selectedIndex == index
                    ? Border(
                        bottom: BorderSide(
                          width: Dimens.space3,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : null,
              ),
              child: Text(
                widget.title[index],
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.space18),
        child: widget.tabViews[_selectedIndex],
      ),
    ],
  );
}

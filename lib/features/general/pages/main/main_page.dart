import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/general/pages/main/side_navigation_bar.dart';

class MainPage extends StatelessWidget {
  const MainPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Parent(
    child: Row(
      children: [
        // Side Navigation Bar
        SideNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            // handle state management dan URL updates
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
        ),

        // Main Content Area
        Expanded(child: navigationShell),
      ],
    ),
  );
}

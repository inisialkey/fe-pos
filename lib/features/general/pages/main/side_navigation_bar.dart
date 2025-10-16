import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

class SideNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const SideNavigationBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.horizontal(
      right: Radius.circular(Dimens.space30),
    ),
    child: Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Spacer untuk center items
                const Spacer(),

                // Navigation Items
                NavigationItem(
                  iconPath: Images.homeResto,
                  isActive: currentIndex == 0,
                  onTap: () => onDestinationSelected(0),
                ),
                NavigationItem(
                  iconPath: Images.discount,
                  isActive: currentIndex == 1,
                  onTap: () => onDestinationSelected(1),
                ),
                NavigationItem(
                  iconPath: Images.dashboard,
                  isActive: currentIndex == 2,
                  onTap: () => onDestinationSelected(2),
                ),
                NavigationItem(
                  iconPath: Images.setting,
                  isActive: currentIndex == 3,
                  onTap: () => onDestinationSelected(3),
                ),

                NavigationItem(
                  iconPath: Images.logout,
                  isActive: false,
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(
                        Strings.of(context)!.logout,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).extension<PosColors>()!.red,
                        ),
                      ),
                      content: Text(
                        Strings.of(context)!.logoutDesc,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            Strings.of(context)!.cancel,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                        BlocListener<LogoutCubit, LogoutState>(
                          listener: (ctx, state) => switch (state) {
                            LogoutStateLoading() => ctx.show(),
                            LogoutStateFailure(:final message) => (() {
                              ctx.dismiss();
                              message.toToastError(context);
                            })(),
                            LogoutStateSuccess(:final message) => (() {
                              ctx.dismiss();
                              message.toToastSuccess(context);
                              context.goNamed(Routes.root.name);
                            })(),
                          },
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<LogoutCubit>().postLogout();
                            },
                            child: Text(
                              Strings.of(context)!.yes,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).extension<PosColors>()!.red,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spacer untuk center items
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

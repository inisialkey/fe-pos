import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pos/core/core.dart';

class NavigationItem extends StatelessWidget {
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;
  final Color color;

  const NavigationItem({
    required this.iconPath,
    required this.isActive,
    required this.onTap,
    super.key,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.all(Radius.circular(Dimens.space16)),
    child: Padding(
      padding: EdgeInsets.all(Dimens.space20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.space12)),
        child: ColoredBox(
          color: isActive
              ? Palette.disabled.withValues(alpha: 0.25)
              : Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(Dimens.space20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Dimens.space25,
                  height: Dimens.space25,
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

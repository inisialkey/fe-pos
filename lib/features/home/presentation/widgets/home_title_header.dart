import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos/core/core.dart';
import 'package:pos/utils/utils.dart';

class HomeTitleHeader extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value)? onChanged;

  const HomeTitleHeader({required this.controller, super.key, this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RESTO KEY POS',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 22.w,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SpacerV(value: Dimens.space4),
          Text(
            DateTime.now().toFormattedDate(),
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(color: Palette.subtitle),
          ),
        ],
      ),
      SizedBox(
        width: Dimens.searchBar,
        child: SearchF(
          controller: controller,
          onChanged: onChanged,
          hintText: 'Search for food, coffe, etc..',
        ),
      ),
    ],
  );
}

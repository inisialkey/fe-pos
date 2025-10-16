import 'package:flutter/material.dart';
import 'package:pos/core/core.dart';

class ButtonBorder extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double? width;
  final Color? color;
  final Color? titleColor;
  final double? fontSize;
  final Color? splashColor;

  const ButtonBorder({
    required this.title,
    required this.onPressed,
    super.key,
    this.width,
    this.color,
    this.titleColor,
    this.fontSize,
    this.splashColor,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        side: BorderSide(color: Theme.of(context).primaryColor),
        backgroundColor:
            color ?? Theme.of(context).extension<PosColors>()!.background,
        foregroundColor: Theme.of(context).extension<PosColors>()!.buttonText,
        disabledBackgroundColor: Theme.of(
          context,
        ).extension<PosColors>()!.buttonText?.withValues(alpha: 0.5),
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.space24,
          vertical: Dimens.space12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.buttonRadius)),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: Theme.of(context).primaryColor),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

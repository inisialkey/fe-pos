import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/core.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.goNamed(Routes.root.name);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Parent(
    child: ColoredBox(
      color: Theme.of(context).extension<PosColors>()!.background!,
      child: Center(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? Images.icLauncherDark
              : Images.icLauncher,
          width: Dimens.imgSplash,
        ),
      ),
    ),
  );
}

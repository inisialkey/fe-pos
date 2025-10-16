import 'package:flutter/material.dart';
import 'package:pos/core/core.dart';

extension ContextExtensions on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;

  double widthInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.width * toDouble;
  }

  double heightInPercent(double percent) {
    final toDouble = percent / 100;

    return MediaQuery.of(this).size.height * toDouble;
  }

  //Start Loading Dialog
  static late BuildContext ctx;

  Future<void> show() => showDialog(
    context: this,
    barrierDismissible: false,
    builder: (c) {
      ctx = c;

      return PopScope(
        canPop: false,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(c).extension<PosColors>()!.background,
                borderRadius: BorderRadius.circular(Dimens.cornerRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: Dimens.space30),
              padding: EdgeInsets.all(Dimens.space24),
              child: const Loading(),
            ),
          ),
        ),
      );
    },
  );

  void dismiss() {
    try {
      Navigator.pop(ctx);
    } catch (_) {}
  }
}

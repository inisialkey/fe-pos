import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pos/core/core.dart';
import 'package:pos/utils/utils.dart';

extension StringExtension on String {
  bool isValidEmail() => RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  ).hasMatch(this);

  //https://github.com/ponnamkarthik/FlutterToast/issues/262
  //coverage:ignore-start
  void toToastError(BuildContext context, {bool isUnitTest = false}) {
    try {
      final message = isEmpty ? 'error' : this;

      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<PosColors>()!.red,
          icon: Icons.error,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      if (!isUnitTest) {
        FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
      }
      log.e('error $e');
    }
  }

  void toToastSuccess(BuildContext context, {bool isUnitTest = false}) {
    try {
      final message = isEmpty ? 'success' : this;

      //dismiss before show toast
      dismissAllToast(showAnim: true);

      // showToast(msg)
      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<PosColors>()!.green,
          icon: Icons.check_circle,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      if (!isUnitTest) {
        FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
      }
      log.e('$e');
    }
  }

  void toToastLoading(BuildContext context, {bool isUnitTest = false}) {
    try {
      final message = isEmpty ? 'loading' : this;
      //dismiss before show toast
      dismissAllToast(showAnim: true);

      showToastWidget(
        Toast(
          bgColor: Theme.of(context).extension<PosColors>()!.pink,
          icon: Icons.info,
          message: message,
          textColor: Colors.white,
        ),
        dismissOtherToast: true,
        position: ToastPosition.top,
        duration: const Duration(seconds: 3),
      );
    } catch (e, stackTrace) {
      if (!isUnitTest) {
        FirebaseCrashLogger().nonFatalError(error: e, stackTrace: stackTrace);
      }
      log.e('$e');
    }
  }

  //coverage:ignore-end

  String toStringDateAlt({bool isShort = false, bool isToLocal = true}) {
    try {
      DateTime object;
      if (isToLocal) {
        object = DateTime.parse(this).toLocal();
      } else {
        object = DateTime.parse(this);
      }

      return DateFormat(
        "dd ${isShort ? "MMM" : "MMMM"} yyyy HH:mm",
        'id',
      ).format(object);
    } catch (_) {
      return '-';
    }
  }

  int get toIntegerFromText {
    final cleanedText = replaceAll(RegExp('[^0-9]'), '');
    return int.tryParse(cleanedText) ?? 0;
  }
}

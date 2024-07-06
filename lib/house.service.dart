import 'package:flutter/material.dart';

class HouseService {
  static HouseService? _instance;
  static HouseService get instance => _instance ??= HouseService._();

  HouseService._();

  /// Global BuildContext
  ///
  /// 앱의 global build context 를 사용한다.
  ///
  /// House 에서 snackbar 등을 사용할 때, global build context 를 사용하면,
  /// 앱에서 페이지를 이동해도 snackbar 닫기 등을 할 수 있다.
  // BuildContext Function()? _globalContext;
  // BuildContext? get globalContext => _globalContext?.call();

  /// Confirm Dialog this callback is used to customize all the confirm functions
  /// in fireflutter see `lib/fireflutter.functions.dart`
  Future<bool?> Function({
    required BuildContext context,
    required String? title,
    required String message,
  })? confirmDialog;

  /// Error Dialog this callback is used to customize all the error functions in
  /// fireflutter see `lib/fireflutter.functions.dart`
  Future<bool?> Function({
    required BuildContext context,
    required String? title,
    required String message,
  })? errorDialog;

  /// Alert Dialog this callback is use to customize the alert functions in fireflutter
  /// see `lib/fireflutter.functions.dart`
  Future<void> Function({
    required BuildContext context,
    required String? title,
    required String message,
  })? alertDialog;

  /// Input Dialog this callback is used to customize all the input functions
  /// in fireflutter. see `lib/fireflutter.functions.dart`
  Future<String?> Function({
    required BuildContext context,
    required String title,
    required String? subtitle,
    required String hintText,
    required String? initialValue,
    required int? minLines,
    required int? maxLines,
  })? inputDialog;

  init({
    // String? cloudFunctionRegion,
    // Color? toastBackgroundColor,
    // Color? toastForegroundColor,
    // BuildContext Function()? globalContext,
    Future<bool?> Function({
      required BuildContext context,
      required String? title,
      required String message,
    })? confirmDialog,
    Future<bool?> Function({
      required BuildContext context,
      required String? title,
      required String message,
    })? errorDialog,
    Future<void> Function({
      required BuildContext context,
      required String? title,
      required String message,
    })? alertDialog,
    Future<String?> Function({
      required BuildContext context,
      required String title,
      required String? subtitle,
      required String hintText,
      required String? initialValue,
      required int? minLines,
      required int? maxLines,
    })? inputDialog,
  }) {
    // _globalContext = globalContext;
    this.confirmDialog = confirmDialog;
    this.errorDialog = errorDialog;
    this.alertDialog = alertDialog;
    this.inputDialog = inputDialog;
  }
}

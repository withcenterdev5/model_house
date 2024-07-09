import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

/// Confirm dialgo
///
/// It requires build context.
///
/// Return true if the user taps on the 'Yes' button.
Future<bool?> confirm({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return HouseService.instance.confirmDialog
          ?.call(context: context, title: title, message: message) ??
      showDialog<bool?>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('no'.t),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('yes'.t),
              ),
            ],
          );
        },
      );
}

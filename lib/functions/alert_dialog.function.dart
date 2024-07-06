import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

Future<void> alert({
  required BuildContext context,
  required String title,
  required String message,
}) async {
  return HouseService.instance.alertDialog?.call(
        context: context,
        title: title,
        message: message,
      ) ??
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('close'.t),
              ),
            ],
          );
        },
      );
}

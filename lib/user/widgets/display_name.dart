import 'package:flutter/material.dart';

class DisplayName extends StatelessWidget {
  const DisplayName({super.key, this.uid, this.initialData});

  final String? uid;
  final String? initialData;

  @override
  Widget build(BuildContext context) {
    return Text(
      initialData ?? 'Anonymous',
    );
  }
}

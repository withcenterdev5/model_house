import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class DisplayName extends StatelessWidget {
  const DisplayName({
    super.key,
    required this.user,
    this.maxLines = 1,
    this.overflow,
    this.length = 6,
  });

  final User user;
  final int maxLines;
  final TextOverflow? overflow;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Text(
      user.displayName.cut(length),
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}

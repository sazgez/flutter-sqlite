import 'package:flutter/material.dart';
import 'package:sqflite_demo/utils/extensions.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    this.child,
    this.height,
  });

  final Widget? child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final deviceSize = context.deviceSize;

    return Container(
      width: deviceSize.width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors.primaryContainer,
      ),
      child: child,
    );
  }
}

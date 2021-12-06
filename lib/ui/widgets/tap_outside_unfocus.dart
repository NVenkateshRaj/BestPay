import 'package:flutter/material.dart';

/// Simple wrapper that will clear focus when a tap is detected outside its boundaries
class TapOutsideUnFocus extends StatelessWidget {
  final Widget child;

  TapOutsideUnFocus({required this.child});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: this.child
      );
  }
}
import 'package:flutter/material.dart';

class CustomGradientBackground extends StatelessWidget {
  const CustomGradientBackground(
      {super.key,
      this.child,
      this.colors,
      this.begin = Alignment.topRight,
      this.end = Alignment.bottomLeft});

  final Widget? child;
  final List<Color>? colors;
  final Alignment begin;
  final Alignment end;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: colors ??
            [
              const Color(0xFFD8FFE8),
              const Color(0xFFECFFF8),
              const Color(0xFF99F1D7)
            ],
        begin: begin,
        end: end,
      )),
      child: child,
    );
  }
}

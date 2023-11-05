import 'package:flutter/material.dart';

class CustomGradientBackground extends StatelessWidget {
  const CustomGradientBackground({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color(0xFFD8FFE8), Color(0xFFECFFF8), Color(0xFF99F1D7)],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      child: child,
    );
  }
}

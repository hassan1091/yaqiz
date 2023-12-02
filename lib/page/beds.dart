import 'package:flutter/material.dart';
import 'package:yaqiz/widget/bed_card_grid.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class BedsPage extends StatelessWidget {
  const BedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
          child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: kToolbarHeight),
          SizedBox(
            height: kToolbarHeight,
            child: IconButton(
                alignment: Alignment.centerLeft,
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          const SizedBox(height: 16),
          const Text("Devices",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const BedCardGrid(),
        ],
      )),
    );
  }
}

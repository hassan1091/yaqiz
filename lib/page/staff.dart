import 'package:flutter/material.dart';
import 'package:yaqiz/page/home.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
            const Text("Staff #",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Select Bed"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              style: const ButtonStyle(alignment: Alignment.centerLeft),
              child: const Text("Staff Screen"),
            ),
          ]),
        ),
      ),
    );
  }
}

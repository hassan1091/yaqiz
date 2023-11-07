import 'package:flutter/material.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color(0xff32998D),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 250,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Your request has been sent to the administrator.",
                    style: TextStyle(color: Color(0xff61948E), fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "(It will take 1~3 days)",
                    style: TextStyle(color: Color(0xff0B7178), fontSize: 16),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 124),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Back"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

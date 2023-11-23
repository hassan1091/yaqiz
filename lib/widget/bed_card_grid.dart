import 'package:flutter/material.dart';
import 'package:yaqiz/page/bed.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class BedCardGrid extends StatelessWidget {
  const BedCardGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 32),
      itemCount: 3,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        clipBehavior: Clip.hardEdge,
        child: CustomGradientBackground(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.red.shade400,
            Colors.red.shade200,
            Colors.white
          ],
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Bed())),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset("assets/life_line.png",
                        height: 100, color: Colors.white),
                    Text("BED $index",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const Text("Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

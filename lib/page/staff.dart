import 'package:flutter/material.dart';
import 'package:yaqiz/page/home.dart';
import 'package:yaqiz/page/select_bed.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class StaffPage extends StatelessWidget {
  const StaffPage(this.employeeID, {super.key});

  final int employeeID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text("Staff $employeeID",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _SelectCard(
                      label: "Select Beds",
                      assets: "bed",
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectBedPage(),
                          ))),
                  const SizedBox(width: 32),
                  _SelectCard(
                      label: "Staff screen",
                      assets: "staff_screen",
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectCard extends StatelessWidget {
  const _SelectCard(
      {required this.onTap, required this.label, required this.assets});

  final String label;
  final String assets;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        clipBehavior: Clip.hardEdge,
        child: CustomGradientBackground(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey,
            Colors.blueGrey.shade400,
            Colors.blueGrey.shade200,
            Colors.white,
          ],
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: onTap,
              child: Expanded(
                child: Column(children: [
                  Image.asset("assets/$assets.png",
                      height: 100, color: Colors.white),
                  Text(label,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

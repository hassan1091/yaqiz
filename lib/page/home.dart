import 'package:flutter/material.dart';
import 'package:yaqiz/page/beds.dart';
import 'package:yaqiz/page/contact.dart';
import 'package:yaqiz/page/login.dart';
import 'package:yaqiz/widget/bed_card_grid.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            const SizedBox(height: kToolbarHeight),
            SizedBox(
              height: kToolbarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactPage()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.login_outlined),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Text("Hi, Anas",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              clipBehavior: Clip.hardEdge,
              elevation: 10,
              child: Column(
                children: [
                  const CustomGradientBackground(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Remainder"), Text("28 Sep")],
                      ),
                    ),
                  ),
                  CustomGradientBackground(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: 4,
                        padding: const EdgeInsets.only(bottom: 16),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text(
                                  "Visit bed $index",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontStyle: FontStyle.italic,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const Text(
                                "01:51:39",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Beds",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BedsPage(),
                          ));
                    },
                    child: const Text("Show more")),
              ],
            ),
            const SizedBox(height: 12),
            const BedCardGrid()
          ],
        ),
      ),
    );
  }
}

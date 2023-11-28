import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/page/bed.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class BedCardGrid extends StatefulWidget {
  const BedCardGrid({
    super.key,
  });

  @override
  State<BedCardGrid> createState() => _BedCardGridState();
}

class _BedCardGridState extends State<BedCardGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getDevices(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemCount: snapshot.data!.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) => Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
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
                          Text("Device: ${snapshot.data![index].id}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                          Text(snapshot.data![index].location!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300)),
                          const SizedBox(),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

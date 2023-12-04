import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/page/bed.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class BedCardGrid extends StatefulWidget {
  const BedCardGrid({
    super.key,
    this.employeeID,
  });

  final int? employeeID;

  @override
  State<BedCardGrid> createState() => _BedCardGridState();
}

class _BedCardGridState extends State<BedCardGrid> {
  final _colors = [
    [
      Colors.green,
      Colors.green.shade400,
      Colors.green.shade200,
      Colors.white,
    ],
    [
      Colors.orange,
      Colors.orange.shade400,
      Colors.orange.shade200,
      Colors.white,
    ],
    [
      Colors.red,
      Colors.red.shade400,
      Colors.red.shade200,
      Colors.white,
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiService().getDevices(id: widget.employeeID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.data!.isEmpty) {
          return Center(
              child: IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.refresh)));
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
                colors: _colors[snapshot.data![index].priority! - 1],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Bed(
                                  deviceId: snapshot.data![index].id!,
                                  employeeID: widget.employeeID,
                                ))),
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

import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class SelectBedPage extends StatefulWidget {
  const SelectBedPage({super.key, required this.employeeID});

  final int employeeID;

  @override
  State<SelectBedPage> createState() => _SelectBedPageState();
}

class _SelectBedPageState extends State<SelectBedPage> {
  late List<bool> _selectedBeds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: kToolbarHeight),
              SizedBox(
                height: kToolbarHeight,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text("Select Devices",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: FutureBuilder(
                  future: ApiService().getAllDevices(id: widget.employeeID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    _selectedBeds =
                        snapshot.data!.map((e) => e.has).cast<bool>().toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _selectedBeds.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text('Device ${snapshot.data![index].id}'),
                          value: _selectedBeds[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedBeds[index] = value!;
                            });
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

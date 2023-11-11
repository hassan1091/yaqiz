import 'package:flutter/material.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class SelectBedPage extends StatefulWidget {
  const SelectBedPage({super.key});

  @override
  State<SelectBedPage> createState() => _SelectBedPageState();
}

class _SelectBedPageState extends State<SelectBedPage> {
  final List<bool> _selectedBeds = List.generate(5, (index) => false);

  void _showSelectedBeds() {
    final selectedBeds = _selectedBeds.asMap().entries.where((entry) => entry.value).map((entry) => entry.key).toList();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selected Beds'),
          content: Text('You selected bed(s): ${selectedBeds.join(', ')}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              const Text("Select Bed", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _selectedBeds.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text('Bed $index'),
                      value: _selectedBeds[index],
                      onChanged: (value) {
                        setState(() {
                          _selectedBeds[index] = value!;
                        });
                      },
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _showSelectedBeds,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

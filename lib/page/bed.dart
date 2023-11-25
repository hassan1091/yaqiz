import 'package:flutter/material.dart';
import 'package:yaqiz/page/reminder.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class Bed extends StatelessWidget {
  const Bed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              const Text(
                "Bed 4",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _HeartCard(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        _BloodPressureCard(),
                        SizedBox(height: 16),
                        _TemperatureCard(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _O2Card(),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff5DCCFC))),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReminderPage())),
                  child: const Text("SET A REMINDER"))
            ],
          ),
        ),
      ),
    );
  }
}

class _HeartCard extends StatelessWidget {
  const _HeartCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: CustomGradientBackground(
        begin: Alignment.center,
        end: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Heart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Image.asset("assets/heart_cut.png", height: 100),
              const SizedBox(height: 16),
              const Text(
                "105",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "bpm",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "105 BPM, 1min ago",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BloodPressureCard extends StatelessWidget {
  const _BloodPressureCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: CustomGradientBackground(
        colors: [
          const Color(0xff088475),
          const Color(0xff088475).withOpacity(0.5),
          const Color(0xff088475).withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Blood Pressure",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Current",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "120",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/blood_drop.png",
                        width: 50,
                        color: Colors.white,
                      ),
                      const Text(
                        "mmHg",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                "120 mmHg, 1min ago",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TemperatureCard extends StatelessWidget {
  const _TemperatureCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: CustomGradientBackground(
        colors: [
          const Color(0xff088475),
          const Color(0xff088475).withOpacity(0.5),
          const Color(0xff088475).withOpacity(0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "37.6",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Celsius",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _O2Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/o2.png",
          fit: BoxFit.fill,
        ),
        const Positioned(
          top: 50,
          left: 50,
          child: Text(
            'SpO2',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Positioned(
          top: 75, // Adjust the top position according to your needs
          left: 75, // Adjust the left position according to your needs
          child: Text(
            '91%',
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

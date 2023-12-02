import 'package:flutter/material.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/page/reminder.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class Bed extends StatefulWidget {
  const Bed({super.key, required this.deviceId});

  final int deviceId;

  @override
  State<Bed> createState() => _BedState();
}

class _BedState extends State<Bed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder(
            future: ApiService().getVital(deviceId: widget.deviceId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {});
                },
                child: ListView(
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
                    Text(
                      "Device ${widget.deviceId}",
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _HeartCard(snapshot.data!.hr!),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              _BloodPressureCard(snapshot.data!.bp!),
                              const SizedBox(height: 16),
                              _TemperatureCard(snapshot.data!.temp!),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _RespiratoryRateCard(snapshot.data!.respiratoryRate!),
                    _O2Card(snapshot.data!.spo2!),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReminderPage(widget.deviceId))),
                        child: const Text("SET A REMINDER"))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HeartCard extends StatelessWidget {
  const _HeartCard(this.bpm);

  final num bpm;

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
              Text(
                "$bpm",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                "bpm",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "$bpm BPM, 1min ago",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
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
  const _BloodPressureCard(this.bp);

  final String bp;

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
                  Text(
                    bp,
                    style: const TextStyle(
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
  const _TemperatureCard(this.temp);

  final num temp;

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$temp",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
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
  const _O2Card(this.spo2);

  final int spo2;

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
        Positioned(
          top: 75, // Adjust the top position according to your needs
          left: 75, // Adjust the left position according to your needs
          child: Text(
            '$spo2%',
            style: const TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

class _RespiratoryRateCard extends StatelessWidget {
  const _RespiratoryRateCard(this.respiratoryRate);

  final int respiratoryRate;

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
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Respiratory Rate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                )),
            Text("$respiratoryRate",
                style: const TextStyle(
                  fontSize: 56,
                )),
            const Text("Respiratory / min",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
          ]),
          Image.asset(
            "assets/respiratory.png",
            height: 150,
          )
        ]),
      ),
    );
  }
}

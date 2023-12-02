import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/page/bed.dart';
import 'package:yaqiz/page/beds.dart';
import 'package:yaqiz/page/contact.dart';
import 'package:yaqiz/page/login.dart';
import 'package:yaqiz/page/staff.dart';
import 'package:yaqiz/widget/bed_card_grid.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.isAdmin = false}) : super(key: key);
  final bool isAdmin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: FutureBuilder(
          future: ApiService().getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return ListView(
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
                        onPressed: _logout,
                      ),
                    ],
                  ),
                ),
                Text("Hi, ${snapshot.data!.employeeID}",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                if (widget.isAdmin) ...[
                  const Text("Doctors",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      itemCount: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        children: [
                          IconButton(
                              iconSize: 64,
                              padding: EdgeInsets.zero,
                              color: Colors.blue,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const StaffPage()));
                              },
                              icon: const Icon(
                                CupertinoIcons.person_alt_circle,
                              )),
                          Text("Staff $index")
                        ],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 12),
                    ),
                  )
                ],
                Card(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(42),
                  ),
                  clipBehavior: Clip.hardEdge,
                  elevation: 10,
                  child: Column(
                    children: [
                      CustomGradientBackground(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Remainder"),
                              Text(
                                  "${DateTime.now().day}/${DateTime.now().month}")
                            ],
                          ),
                        ),
                      ),
                      const _RemainderList(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Beds",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
            );
          },
        ),
      ),
    );
  }

  void _logout() {
    ApiService()
        .logout()
        .then((_) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            ))
        .onError(
          (error, stackTrace) => showDialog(
              context: context,
              builder: (context) => AlertDialog(title: Text(error.toString()))),
        );
  }
}

class _RemainderList extends StatefulWidget {
  const _RemainderList();

  @override
  State<_RemainderList> createState() => _RemainderListState();
}

class _RemainderListState extends State<_RemainderList> {
  Timer? _timer;
  final ValueNotifier<List<AlarmInfo>> _alarmsNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _fetchAlarms();
    _clearExpiredAlarms();

    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      _fetchAlarms();
      _clearExpiredAlarms();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _fetchAlarms() async {
    final alarms = Hive.box<AlarmInfo>('alarms').values.toList();
    _alarmsNotifier.value = alarms;
  }

  void _clearExpiredAlarms() async {
    final currentDay = DateTime.now();
    final expiredAlarms = Hive.box<AlarmInfo>('alarms')
        .values
        .where((alarm) => alarm.alarmDateTime.isBefore(currentDay))
        .toList();

    for (final alarm in expiredAlarms) {
      await Hive.box<AlarmInfo>('alarms').delete(alarm.key);
    }

    _fetchAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _alarmsNotifier,
      builder: (context, value, child) => CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: value.length,
            padding: const EdgeInsets.only(bottom: 16),
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Bed(deviceId: int.parse(value[index].title)))),
                    child: Text(
                      "Visit Device:${value[index].title}",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    "${value[index].alarmDateTime.hour}:${value[index].alarmDateTime.minute}",
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

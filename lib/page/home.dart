import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/api/api_service.dart';
import 'package:yaqiz/notification_service..dart';
import 'package:yaqiz/page/bed.dart';
import 'package:yaqiz/page/beds.dart';
import 'package:yaqiz/page/contact.dart';
import 'package:yaqiz/page/login.dart';
import 'package:yaqiz/page/staff.dart';
import 'package:yaqiz/widget/bed_card_grid.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.isSupervisor = false, this.employeeID})
      : super(key: key);
  final bool isSupervisor;
  final int? employeeID;

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
                  child: widget.employeeID == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.person_outline),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ContactPage()));
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.login_outlined),
                              onPressed: _logout,
                            ),
                          ],
                        )
                      : IconButton(
                          alignment: Alignment.centerLeft,
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                ),
                Text("Hi, ${snapshot.data!.employeeID}",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                if (widget.isSupervisor) ...[
                  const Text("Doctors",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const _DoctorsList()
                ],
                if (widget.employeeID == null)
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
                        const RemainderList(),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Devices",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BedsPage(employeeID: widget.employeeID),
                              ));
                        },
                        child: const Text("Show more")),
                  ],
                ),
                const SizedBox(height: 12),
                BedCardGrid(employeeID: widget.employeeID)
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

class _DoctorsList extends StatelessWidget {
  const _DoctorsList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FutureBuilder(
        future: ApiService().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
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
                              builder: (context) => StaffPage(
                                  snapshot.data![index].employeeID!)));
                    },
                    icon: const Icon(
                      CupertinoIcons.person_alt_circle,
                    )),
                Text("Staff ${snapshot.data![index].employeeID}")
              ],
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(width: 12),
          );
        },
      ),
    );
  }
}

class RemainderList extends StatefulWidget {
  const RemainderList({super.key, this.employeeID});

  final int? employeeID;

  @override
  State<RemainderList> createState() => _RemainderListState();
}

class _RemainderListState extends State<RemainderList> {
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
    final currentDay = DateTime.now().copyWith(
      day: DateTime.now().day + 1,
      minute: 0,
      hour: 0,
      second: 0,
    );
    final expiredAlarms = Hive.box<AlarmInfo>('alarms')
        .values
        .where((alarm) => alarm.alarmDateTime.isBefore(currentDay))
        .toList();

    for (final alarm in expiredAlarms) {
      await Hive.box<AlarmInfo>('alarms').delete(alarm.key);
      NotificationService(
        flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
      ).showNotification(
          title: "Yaqiz your attention",
          body:
              "Remainder for devise ${alarm.title} comments: ${alarm.comment}");
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
                            builder: (context) => Bed(
                                deviceId: int.parse(value[index].title),
                                employeeID: widget.employeeID))),
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

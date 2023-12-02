import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:yaqiz/alarm_info.dart';
import 'package:yaqiz/widget/custom_gradient_background.dart';
import 'package:yaqiz/widget/my_text_form_field.dart';
import 'package:yaqiz/widget/smart_switch.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage(this.deviceId, {super.key});

  final int deviceId;

  @override
  State<ReminderPage> createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;

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
                "REMINDER",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TimeInput(onChange: (int hour, int minute) {
                setState(() {
                  _hour = hour;
                  _minute = minute;
                });
              }),
              const SizedBox(height: 16),
              const MyTextFormField(
                lable: "Comment",
                hint: "Please write a comment for this visit and next visit",
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xff5DCCFC))),
                  onPressed: _addAlarm,
                  child: const Text("SET A REMINDER"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addAlarm() async {
    AlarmInfo alarmInfo = AlarmInfo(
        alarmDateTime: DateTime.now().copyWith(hour: _hour, minute: _minute),
        title: widget.deviceId.toString(),
        isPending: true);
    Hive.box<AlarmInfo>('alarms')
        .add(alarmInfo)
        .then((value) => Navigator.pop(context))
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }
}

class TimeInput extends StatefulWidget {
  const TimeInput({super.key, required this.onChange});

  final void Function(int hours, int minute) onChange;

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  int _hour = DateTime.now().hour;
  int _minute = DateTime.now().minute;
  bool _isAM = DateTime.now().hour < 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            'Visit Time: ${_hour.toString().padLeft(2, '0')} : ${_minute.toString().padLeft(2, '0')} ${_isAM ? 'AM' : 'PM'}'),
        const SizedBox(height: 20),
        Row(
          children: [
            Card(
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                    width: 20,
                    child: ListWheelScrollView(
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _hour = value;
                          widget.onChange(_minute, _hour);
                        });
                      },
                      itemExtent: 20,
                      children: List.generate(12,
                          (index) => Text(index.toString().padLeft(2, '0'))),
                    ),
                  ),
                  const Text(' : '),
                  SizedBox(
                    height: 30,
                    width: 20,
                    child: ListWheelScrollView(
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _minute = value;
                          widget.onChange(_minute, _hour);
                        });
                      },
                      itemExtent: 20,
                      children: List.generate(60,
                          (index) => Text(index.toString().padLeft(2, '0'))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SmartSwitch(
              offText: "AM",
              onText: "PM",
              onChanged: (value) {
                setState(() {
                  _isAM = !value;
                  _hour = (_hour + 12) % 24;
                  widget.onChange(_minute, _hour);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

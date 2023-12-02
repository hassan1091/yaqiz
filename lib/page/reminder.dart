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
  final commentController = TextEditingController();
  int _hour = 0;
  int _minute = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
              MyTextFormField(
                lable: "Comment",
                hint: "Please write a comment for this visit and next visit",
                controller: commentController,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _addAlarm, child: const Text("SET A REMINDER"))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addAlarm() async {
    DateTime time = DateTime.now().copyWith(hour: _hour, minute: _minute);
    if (!time.isBefore(DateTime.now())) {
      AlarmInfo alarmInfo = AlarmInfo(
          alarmDateTime: time,
          title: widget.deviceId.toString(),
          comment: commentController.text);
      Hive.box<AlarmInfo>('alarms')
          .add(alarmInfo)
          .then((value) => Navigator.pop(context))
          .onError((error, stackTrace) => debugPrint(error.toString()));
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
            title: Text("Please, do not add a reminder in the past")),
      );
    }
  }
}

class TimeInput extends StatefulWidget {
  const TimeInput({super.key, required this.onChange});

  final void Function(int hours, int minute) onChange;

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  int _hour = 0;
  int _minute = 0;
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
                      controller:
                          FixedExtentScrollController(initialItem: _hour),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _hour = value;
                          widget.onChange(_hour, _minute);
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
                      controller:
                          FixedExtentScrollController(initialItem: _minute),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _minute = value;
                          widget.onChange(_hour, _minute);
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
                  widget.onChange(_hour, _minute);
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

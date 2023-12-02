import 'package:hive/hive.dart';

part 'alarm_info.g.dart';

@HiveType(typeId: 0)
class AlarmInfo extends HiveObject {
  @HiveField(0)
  DateTime alarmDateTime;

  @HiveField(1)
  String title;

  @HiveField(2)
  String comment;

  AlarmInfo(
      {required this.alarmDateTime,
      required this.title,
      required this.comment});


}

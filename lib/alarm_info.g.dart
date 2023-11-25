// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmInfoAdapter extends TypeAdapter<AlarmInfo> {
  @override
  final int typeId = 0;

  @override
  AlarmInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlarmInfo(
      alarmDateTime: fields[0] as DateTime,
      title: fields[1] as String,
      isPending: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AlarmInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.alarmDateTime)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isPending);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlarmInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 2;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      deadline: fields[0] as DateTime?,
      createdAt: fields[1] as DateTime?,
      changedAt: fields[2] as DateTime?,
      done: fields[3] as bool?,
      text: fields[4] as String?,
      importance: fields[5] as Importance,
      lastUpdatedBy: fields[6] as String?,
      id: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.deadline)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.changedAt)
      ..writeByte(3)
      ..write(obj.done)
      ..writeByte(4)
      ..write(obj.text)
      ..writeByte(5)
      ..write(obj.importance)
      ..writeByte(6)
      ..write(obj.lastUpdatedBy)
      ..writeByte(7)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

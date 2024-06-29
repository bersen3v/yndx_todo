// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'importance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImportanceAdapter extends TypeAdapter<Importance> {
  @override
  final int typeId = 3;

  @override
  Importance read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Importance.low;
      case 1:
        return Importance.basic;
      case 2:
        return Importance.important;
      default:
        return Importance.low;
    }
  }

  @override
  void write(BinaryWriter writer, Importance obj) {
    switch (obj) {
      case Importance.low:
        writer.writeByte(0);
        break;
      case Importance.basic:
        writer.writeByte(1);
        break;
      case Importance.important:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImportanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

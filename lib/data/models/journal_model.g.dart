// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JournalModelAdapter extends TypeAdapter<JournalModel> {
  @override
  final int typeId = 0;

  @override
  JournalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JournalModel(
      id: fields[0] as String,
      date: fields[1] as String,
      ambienceTitle: fields[2] as String,
      mood: fields[3] as String,
      entry: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JournalModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.ambienceTitle)
      ..writeByte(3)
      ..write(obj.mood)
      ..writeByte(4)
      ..write(obj.entry);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

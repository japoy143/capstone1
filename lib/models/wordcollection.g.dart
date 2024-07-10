// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordcollection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordCollectionAdapter extends TypeAdapter<WordCollection> {
  @override
  final int typeId = 2;

  @override
  WordCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordCollection(
      username: fields[1] as String,
      wordcollected: (fields[2] as List).cast<String>(),
      date: fields[3] as DateTime,
    )..id = fields[0] == null ? 0 : fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, WordCollection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.wordcollected)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

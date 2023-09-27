// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scores.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class scoresAdapter extends TypeAdapter<scores> {
  @override
  final int typeId = 0;

  @override
  scores read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return scores(
      id: fields[0] == null ? 0 : fields[0] as int,
      username: fields[1] as String,
      compScore: fields[2] as int,
      genScore: fields[3] as int,
      totalScore: fields[4] as int,
      wordPerMinute: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, scores obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.compScore)
      ..writeByte(3)
      ..write(obj.genScore)
      ..writeByte(4)
      ..write(obj.totalScore)
      ..writeByte(5)
      ..write(obj.wordPerMinute);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is scoresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

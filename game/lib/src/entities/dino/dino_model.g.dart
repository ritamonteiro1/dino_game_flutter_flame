// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dino_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DinoModelAdapter extends TypeAdapter<DinoModel> {
  @override
  final int typeId = 0;

  @override
  DinoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DinoModel().._highScore = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, DinoModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj._highScore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DinoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

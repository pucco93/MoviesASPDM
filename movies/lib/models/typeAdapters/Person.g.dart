// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonHiveAdapter extends TypeAdapter<PersonHive> {
  @override
  final int typeId = 34;

  @override
  PersonHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonHive(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<dynamic>(),
      fields[4] as num,
      fields[5] as String,
    )..mediaType = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, PersonHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.department)
      ..writeByte(3)
      ..write(obj.knownFor)
      ..writeByte(4)
      ..write(obj.popularity)
      ..writeByte(5)
      ..write(obj.posterPath)
      ..writeByte(6)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

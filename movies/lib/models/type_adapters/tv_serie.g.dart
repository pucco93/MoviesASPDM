// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_serie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TVSerieHiveAdapter extends TypeAdapter<TVSerieHive> {
  @override
  final int typeId = 35;

  @override
  TVSerieHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TVSerieHive(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as num,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      (fields[9] as List).cast<int>(),
      fields[10] as double,
      fields[11] as num,
      fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TVSerieHive obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.originalName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.firstAirDate)
      ..writeByte(5)
      ..write(obj.voteAverage)
      ..writeByte(6)
      ..write(obj.backdropPath)
      ..writeByte(7)
      ..write(obj.posterPath)
      ..writeByte(8)
      ..write(obj.originalLanguage)
      ..writeByte(9)
      ..write(obj.genreIds)
      ..writeByte(10)
      ..write(obj.popularity)
      ..writeByte(11)
      ..write(obj.voteCount)
      ..writeByte(12)
      ..write(obj.mediaType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TVSerieHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

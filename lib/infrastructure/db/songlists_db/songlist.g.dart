// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllSongsListsAdapter extends TypeAdapter<AllSongsLists> {
  @override
  final int typeId = 0;

  @override
  AllSongsLists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllSongsLists(
      name: fields[1] as String,
      artist: fields[2] as String,
      uri: fields[3] as String,
      songID: fields[4] as int,
      duration: fields[5] as int,
      count: fields[6] as int?,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AllSongsLists obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.uri)
      ..writeByte(4)
      ..write(obj.songID)
      ..writeByte(5)
      ..write(obj.duration)
      ..writeByte(6)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllSongsListsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

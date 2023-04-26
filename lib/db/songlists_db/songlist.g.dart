// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongsListsAdapter extends TypeAdapter<SongsLists> {
  @override
  final int typeId = 1;

  @override
  SongsLists read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongsLists(
      name: fields[1] as String,
      artist: fields[2] as String,
      uri: fields[3] as String,
      songID: fields[4] as int,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SongsLists obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.uri)
      ..writeByte(4)
      ..write(obj.songID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongsListsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Wikipage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WikiPageAdapter extends TypeAdapter<WikiPage> {
  @override
  final int typeId = 1;

  @override
  WikiPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WikiPage(
      pageid: fields[0] as int,
      index: fields[1] as int,
      title: fields[2] as String,
      thumbnail: fields[3] as String?,
      description: fields[4] as String?,
      fullurl: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WikiPage obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.pageid)
      ..writeByte(1)
      ..write(obj.index)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.fullurl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WikiPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

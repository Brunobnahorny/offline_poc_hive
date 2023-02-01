// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataset_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatasetAdapter extends TypeAdapter<Dataset> {
  @override
  final int typeId = 1;

  @override
  Dataset read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dataset(
      uuid: fields[0] as String,
      uuidPkColumn: fields[2] as String,
      title: fields[1] == null ? '' : fields[1] as String,
      columns: (fields[3] as List).cast<DatasetColumn>(),
    );
  }

  @override
  void write(BinaryWriter writer, Dataset obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.uuidPkColumn)
      ..writeByte(3)
      ..write(obj.columns);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatasetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

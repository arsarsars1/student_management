// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BatchAdapter extends TypeAdapter<Batch> {
  @override
  final int typeId = 0;

  @override
  Batch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Batch(
      name: fields[0] as String,
      course: fields[1] as String,
      subject: fields[2] as String,
      admissionFee: fields[3] as double,
      fees: fields[4] as double,
      status: fields[5] as String,
      email: fields[6] as String,
      students: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Batch obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.course)
      ..writeByte(2)
      ..write(obj.subject)
      ..writeByte(3)
      ..write(obj.admissionFee)
      ..writeByte(4)
      ..write(obj.fees)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.students);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

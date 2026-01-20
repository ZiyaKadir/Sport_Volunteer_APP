// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VolunteerAdapter extends TypeAdapter<Volunteer> {
  @override
  final int typeId = 0;

  @override
  Volunteer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Volunteer(
      idvolunteer: fields[0] as int,
      volunteerName: fields[1] as String,
      volunteerFirstName: fields[2] as String,
      volunteerLastName: fields[3] as String,
      volunteerPassword: fields[4] as String,
      volunteerEposta: fields[5] as String,
      volunteerPhoneNo: fields[6] as String,
      volunteerBirthday: fields[7] as String,
      volunteerGender: fields[8] as String,
      volunteerAddress: fields[9] as String,
      volunteerPhoto: fields[10] as String,
      volunteerJob: fields[11] as String,
      volunteerLanguages: fields[12] as String,
      volunteerBlacklist: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Volunteer obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.idvolunteer)
      ..writeByte(1)
      ..write(obj.volunteerName)
      ..writeByte(2)
      ..write(obj.volunteerFirstName)
      ..writeByte(3)
      ..write(obj.volunteerLastName)
      ..writeByte(4)
      ..write(obj.volunteerPassword)
      ..writeByte(5)
      ..write(obj.volunteerEposta)
      ..writeByte(6)
      ..write(obj.volunteerPhoneNo)
      ..writeByte(7)
      ..write(obj.volunteerBirthday)
      ..writeByte(8)
      ..write(obj.volunteerGender)
      ..writeByte(9)
      ..write(obj.volunteerAddress)
      ..writeByte(10)
      ..write(obj.volunteerPhoto)
      ..writeByte(11)
      ..write(obj.volunteerJob)
      ..writeByte(12)
      ..write(obj.volunteerLanguages)
      ..writeByte(13)
      ..write(obj.volunteerBlacklist);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolunteerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

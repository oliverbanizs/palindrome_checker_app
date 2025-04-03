// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palindrome_result.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PalindromeResultAdapter extends TypeAdapter<PalindromeResult> {
  @override
  final int typeId = 0;

  @override
  PalindromeResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PalindromeResult(
      input: fields[0] as String,
      isPalindrome: fields[1] as bool,
      timeStamp: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PalindromeResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.input)
      ..writeByte(1)
      ..write(obj.isPalindrome)
      ..writeByte(2)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PalindromeResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_timer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTimerModelAdapter extends TypeAdapter<TaskTimerModel> {
  @override
  final int typeId = 1;

  @override
  TaskTimerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskTimerModel(
      totalSeconds: fields[1] as int,
      startTime: fields[2] as DateTime?,
      isRunning: fields[3] as bool,
      taskModel: fields[4] as TaskModel,
    );
  }

  @override
  void write(BinaryWriter writer, TaskTimerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.totalSeconds)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.isRunning)
      ..writeByte(4)
      ..write(obj.taskModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTimerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

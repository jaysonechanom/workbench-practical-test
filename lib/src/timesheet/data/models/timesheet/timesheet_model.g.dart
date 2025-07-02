// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimesheetModel _$TimesheetModelFromJson(Map<String, dynamic> json) =>
    TimesheetModel(
      id: (json['id'] as num).toInt(),
      peopleId: (json['peopleId'] as num).toInt(),
      tasksId: (json['tasksId'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$TimesheetModelToJson(TimesheetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'peopleId': instance.peopleId,
      'tasksId': instance.tasksId,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'notes': instance.notes,
    };

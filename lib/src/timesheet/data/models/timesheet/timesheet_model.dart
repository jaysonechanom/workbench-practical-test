
import 'package:json_annotation/json_annotation.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';
part 'timesheet_model.g.dart';

@JsonSerializable()
class TimesheetModel extends Timesheet {
  const TimesheetModel({
    super.id,
    required super.peopleId,
    required super.tasksId,
    required super.date,
    required super.startTime,
    required super.endTime,
    super.notes,
    super.personName,
    super.taskName,
    super.taskDescription,
  });

  factory TimesheetModel.fromJson(Map<String, dynamic> json) =>
      _$TimesheetModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimesheetModelToJson(this);

  TimesheetModel.fromMap(Map<String, dynamic> map)
      : this(
    id: map['id'] as int,
    peopleId: map['peopleId'] as int,
    tasksId: map['tasksId'] as int,
    date: map['date'] as String,
    startTime: map['startTime'] as String,
    endTime: map['endTime'] as String,
    notes: map['notes'] as String?,
    personName: map['personName'] as String?,
    taskName: map['taskName'] as String?,
    taskDescription: map['taskDescription'] as String?,
  );

}

import 'package:json_annotation/json_annotation.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
part 'tasks_model.g.dart';

@JsonSerializable()
class TasksModel extends Tasks {
  const TasksModel({
    required super.id,
    required super.name,
    required super.description
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) =>
      _$TasksModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksModelToJson(this);

  TasksModel.fromMap(Map<String, dynamic> map)
      : this(
    id: map['id'] as int,
    name: map['name'] as String,
    description: map['description'] as String,
  );

}
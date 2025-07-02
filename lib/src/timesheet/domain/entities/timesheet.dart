
import 'package:equatable/equatable.dart';

class Timesheet extends Equatable {
  final int? id;
  final int peopleId;
  final int tasksId;
  final String date;
  final String startTime;
  final String endTime;
  final String? notes;
  final String? personName;
  final String? taskName;
  final String? taskDescription;

  const Timesheet({this.id,
    required this.peopleId,
    required this.tasksId,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.personName,
    this.taskName,
    this.taskDescription});

  @override
  List<Object?> get props => [id, peopleId, tasksId, date, startTime, endTime, notes];
}
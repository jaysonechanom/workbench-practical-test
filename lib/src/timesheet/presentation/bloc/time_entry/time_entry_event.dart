part of 'time_entry_bloc.dart';

@immutable
sealed class TimeEntryEvent extends Equatable {}

final class OnInitialTimeEntryLoadEvent extends TimeEntryEvent {
  OnInitialTimeEntryLoadEvent();

  @override
  List<Object?> get props => [];
}

final class OnSubmitEvent extends TimeEntryEvent {
  OnSubmitEvent({required this.peopleId,
    required this.taskId,
    required this.date,
    required this.startTime,
    required this.startTimeString,
    required this.endTime,
    required this.endTimeString,
    this.notes,
    this.id});

  final int peopleId;
  final int taskId;
  final DateTime date;
  final TimeOfDay startTime;
  final String startTimeString;
  final TimeOfDay endTime;
  final String endTimeString;
  final String? notes;
  final int? id;

  @override
  List<Object?> get props => [peopleId,
    taskId,
    date,
    startTime,
    startTimeString,
    endTime,
    endTimeString,
    notes
  ];
}

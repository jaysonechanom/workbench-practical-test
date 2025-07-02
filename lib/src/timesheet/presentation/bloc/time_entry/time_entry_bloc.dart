import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/timesheet/timesheet_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/add_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_people_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_tasks_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/update_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/mixin/timesheet_mixin.dart';

part 'time_entry_event.dart';
part 'time_entry_state.dart';

class TimeEntryBloc extends Bloc<TimeEntryEvent, TimeEntryState> with TimesheetMixin {
  final GetTasksListUseCase _getTasksUseCase;
  final GetPeopleListUseCase _getPeopleListUseCase;
  final AddTimesheetUseCase _addTimesheetUseCase;
  final UpdateTimesheetUseCase _updateTimesheetUseCase;

  TimeEntryBloc(this._getPeopleListUseCase,
      this._getTasksUseCase, this._addTimesheetUseCase,
      this._updateTimesheetUseCase) : super(const TimeEntryInitial(null, null)) {
    on<OnInitialTimeEntryLoadEvent>(_onInitialLoadEvent);
    on<OnSubmitEvent>(_onSubmitEvent);
  }

  Future<void> _onInitialLoadEvent(OnInitialTimeEntryLoadEvent event, Emitter<TimeEntryState> emit) async {
    emit(const TimeEntryLoading(null, null));
    await Future.delayed(const Duration(seconds: 1));
    final peopleList = await _getPeopleListUseCase();
    final taskList = await _getTasksUseCase();
    emit(TimeEntrySuccess(peopleList, taskList));
  }

  Future<void> _onSubmitEvent(OnSubmitEvent event, Emitter<TimeEntryState> emit) async {
    try {
      emit(TimeEntrySubmitting(state.peopleList, state.tasksList));
      await Future.delayed(const Duration(seconds: 1));

      final now = DateTime.now();
      final nowRounded = DateTime(now.year, now.month, now.day, now.hour, now.minute);
      final startDateTime = toDateTime(event.date, event.startTime);
      final endDateTime = toDateTime(event.date, event.endTime);

      if (isToday(event.date)) {
        if (startDateTime.isBefore(nowRounded)) {
          throw ("Start time must be greater than or equal to now.");
        }

        if (endDateTime.isBefore(nowRounded)) {
          throw ("End time must be greater than or equal to now.");
        }
      }

      if (!endDateTime.isAfter(startDateTime)) {
        throw ("End time must be after start time.");
      }

      late int result;
      if(event.id == null) {
        result = await _addTimesheetUseCase(TimesheetModel(
            peopleId: event.peopleId,
            tasksId: event.taskId,
            date: event.date.toIso8601String(),
            startTime: '${event.startTime.hour}:${event.startTime.minute}:00',
            endTime: '${event.endTime.hour}:${event.endTime.minute}:00',
            notes: event.notes)
        );
      } else {
        result = await _updateTimesheetUseCase(TimesheetModel(
            id: event.id,
            peopleId: event.peopleId,
            tasksId: event.taskId,
            date: event.date.toIso8601String(),
            startTime: '${event.startTime.hour}:${event.startTime.minute}:00',
            endTime: '${event.endTime.hour}:${event.endTime.minute}:00',
            notes: event.notes)
        );
      }

      if (result == -1) {
        throw ("Something went wrong.");
      }

      emit(TimeEntrySubmitSuccess(state.peopleList,
          state.tasksList, isEdit: event.id != null));
    } catch (e) {
      emit(TimeEntryError(state.peopleList,
          state.tasksList,
          e.toString().replaceAll('Exception: ', '')
      ));
    }

  }
}

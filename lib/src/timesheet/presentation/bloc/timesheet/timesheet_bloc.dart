import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/delete_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_timesheet_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/search_timesheet.dart';

part 'timesheet_event.dart';
part 'timesheet_state.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  final GetTimesheetListUseCase _getTimesheetList;
  final SearchTimesheetUseCase _searchTimesheetUseCase;
  final DeleteTimesheetUseCase _deleteTimesheetUseCase;

  TimesheetBloc(this._getTimesheetList,
      this._searchTimesheetUseCase,
      this._deleteTimesheetUseCase) : super(TimesheetInitial()) {
    on<OnInitialTimesheetLoadEvent>(_onInitialLoadEvent);
    on<OnSearchEvent>(_onSearchEvent);
    on<OnDeleteEvent>(_onDeleteEvent);
  }

  Future<void> _onInitialLoadEvent(OnInitialTimesheetLoadEvent event, Emitter<TimesheetState> emit) async {
    emit(TimesheetLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _getTimesheetList();
    emit(TimesheetSuccess(result));
  }

  Future<void> _onSearchEvent(OnSearchEvent event, Emitter<TimesheetState> emit) async {
    final result = await _searchTimesheetUseCase(event.query);
    emit(TimesheetSuccess(result));
  }

  Future<void> _onDeleteEvent(OnDeleteEvent event, Emitter<TimesheetState> emit) async {
    emit(TimesheetLoading());
    await Future.delayed(const Duration(seconds: 1));

    await _deleteTimesheetUseCase(event.id);
    final result = await _getTimesheetList();
    emit(TimesheetSuccess(result));
  }
}

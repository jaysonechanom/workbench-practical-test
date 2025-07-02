import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_tasks_list.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetTasksListUseCase _getTasksUseCase;

  TasksBloc(this._getTasksUseCase) : super(TasksInitial()) {
    on<OnInitialTasksLoadEvent>(_onInitialLoadEvent);
  }

  Future<void> _onInitialLoadEvent(OnInitialTasksLoadEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _getTasksUseCase();
    emit(TasksSuccess(result));
  }
}

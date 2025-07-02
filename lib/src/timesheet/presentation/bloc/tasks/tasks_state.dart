part of 'tasks_bloc.dart';

@immutable
sealed class TasksState extends Equatable {}

final class TasksInitial extends TasksState {
  @override
  List<Object?> get props => [];
}

final class TasksLoading extends TasksState {
  @override
  List<Object?> get props => [];
}

final class TasksSuccess extends TasksState {
  TasksSuccess(this.tasks);
  final List<Tasks> tasks;

  @override
  List<Object?> get props => [tasks];
}

final class TasksError extends TasksState {
  TasksError(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent extends Equatable {}

final class OnInitialTasksLoadEvent extends TasksEvent {
  OnInitialTasksLoadEvent();

  @override
  List<Object?> get props => [];
}
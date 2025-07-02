part of 'time_entry_bloc.dart';

@immutable
sealed class TimeEntryState extends Equatable {
  final List<People>? peopleList;
  final List<Tasks>? tasksList;

  const TimeEntryState(this.peopleList,
      this.tasksList);
}

final class TimeEntryInitial extends TimeEntryState {
  const TimeEntryInitial(super.peopleList,
      super.tasksList);

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList];
}

final class TimeEntryLoading extends TimeEntryState {
  const TimeEntryLoading(super.peopleList,
      super.tasksList);

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList];
}

final class TimeEntrySuccess extends TimeEntryState {
  const TimeEntrySuccess(super.peopleList,
      super.tasksList);

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList];
}

final class TimeEntrySubmitting extends TimeEntryState {
  const TimeEntrySubmitting(super.peopleList,
      super.tasksList);

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList];
}

final class TimeEntrySubmitSuccess extends TimeEntryState {
  final bool isEdit;
  const TimeEntrySubmitSuccess(super.peopleList,
      super.tasksList, {required this.isEdit});

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList, isEdit];
}

final class TimeEntryError extends TimeEntryState {
  final String error;
  const TimeEntryError(
      super.peopleList,
      super.tasksList,
      this.error);

  @override
  List<Object?> get props => [super.peopleList,
    super.tasksList, error];
}
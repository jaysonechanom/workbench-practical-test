part of 'timesheet_bloc.dart';

@immutable
sealed class TimesheetState extends Equatable {}

final class TimesheetInitial extends TimesheetState {
  @override
  List<Object?> get props => [];
}

final class TimesheetLoading extends TimesheetState {
  @override
  List<Object?> get props => [];
}

final class TimesheetSuccess extends TimesheetState {
  TimesheetSuccess(this.timesheet);
  final List<Timesheet> timesheet;
  @override
  List<Object?> get props => [timesheet];
}

final class TimesheetError extends TimesheetState {
  TimesheetError(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
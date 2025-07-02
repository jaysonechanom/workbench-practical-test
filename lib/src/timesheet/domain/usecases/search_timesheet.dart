
import 'package:workbench_simple_timesheet_app/core/common/usecase/usecase.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/repos/timesheet_repo.dart';

class SearchTimesheetUseCase extends FutureUseCaseWitHParams<List<Timesheet>, String>{
  const SearchTimesheetUseCase(this._repo);

  final TimesheetRepo _repo;

  @override
  Future<List<Timesheet>> call(String params) => _repo.searchTimesheet(params);
}
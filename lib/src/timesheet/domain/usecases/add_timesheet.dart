
import 'package:workbench_simple_timesheet_app/core/common/usecase/usecase.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/models/timesheet/timesheet_model.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/repos/timesheet_repo.dart';

class AddTimesheetUseCase extends FutureUseCaseWitHParams <int, TimesheetModel>{
  const AddTimesheetUseCase(this._repo);

  final TimesheetRepo _repo;

  @override
  Future<int> call(TimesheetModel params) => _repo.addTimesheet(params);

}
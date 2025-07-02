
import 'package:workbench_simple_timesheet_app/core/common/usecase/usecase.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/repos/timesheet_repo.dart';

class GetPeopleListUseCase extends FutureUseCaseWithoutParams<List<People>> {
  const GetPeopleListUseCase(this._repo);

  final TimesheetRepo _repo;

  @override
  Future<List<People>> call() => _repo.getPeopleList();
}
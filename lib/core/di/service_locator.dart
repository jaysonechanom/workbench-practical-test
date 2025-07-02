
import 'package:get_it/get_it.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/datasources/timesheet_local_data_src.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/data/repos/timesheet_repo_impl.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/repos/timesheet_repo.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/add_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/delete_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_people_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_tasks_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_timesheet_list.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/search_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/update_timesheet.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/people/people_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/time_entry/time_entry_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/timesheet/timesheet_bloc.dart';

final GetIt sl  = GetIt.I;

Future setupLocator() async {
  sl.registerLazySingleton<TimesheetLocalDataSrc>(() => TimesheetLocalDataSrc());
  sl.registerLazySingleton<TimesheetRepo>(() => TimesheetRepoImpl(sl()));
  sl.registerLazySingleton<GetPeopleListUseCase>(() => GetPeopleListUseCase(sl()));
  sl.registerFactory<PeopleBloc>(() => PeopleBloc(sl()));
  sl.registerLazySingleton<GetTasksListUseCase>(() => GetTasksListUseCase(sl()));
  sl.registerFactory<TasksBloc>(() => TasksBloc(sl()));
  sl.registerLazySingleton<GetTimesheetListUseCase>(() => GetTimesheetListUseCase(sl()));
  sl.registerFactory<TimesheetBloc>(() => TimesheetBloc(sl(), sl(), sl()));
  sl.registerFactory<TimeEntryBloc>(() => TimeEntryBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton<DeleteTimesheetUseCase>(() => DeleteTimesheetUseCase(sl()));
  sl.registerLazySingleton<AddTimesheetUseCase>(() => AddTimesheetUseCase(sl()));
  sl.registerLazySingleton<UpdateTimesheetUseCase>(() => UpdateTimesheetUseCase(sl()));
  sl.registerLazySingleton<SearchTimesheetUseCase>(() => SearchTimesheetUseCase(sl()));
}
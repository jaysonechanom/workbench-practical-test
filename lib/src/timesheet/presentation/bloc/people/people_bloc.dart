import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/usecases/get_people_list.dart';

part 'people_event.dart';
part 'people_state.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final GetPeopleListUseCase _getPeopleUseCase;

  PeopleBloc(this._getPeopleUseCase) : super(PeopleInitial()) {
    on<OnInitialPeopleLoadEvent>(_onInitialLoadEvent);
  }

  Future<void> _onInitialLoadEvent(OnInitialPeopleLoadEvent event, Emitter<PeopleState> emit) async {
    emit(PeopleLoading());
    await Future.delayed(const Duration(seconds: 1));
    final result = await _getPeopleUseCase();
    emit(PeopleSuccess(result));
  }
}

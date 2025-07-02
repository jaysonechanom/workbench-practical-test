import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbench_simple_timesheet_app/core/common/widget/loading.dart';
import 'package:workbench_simple_timesheet_app/core/di/service_locator.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/people/people_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/item_card.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider(
          create: (context) => sl<PeopleBloc>()..add(OnInitialPeopleLoadEvent()),
          child: BlocBuilder<PeopleBloc, PeopleState>(
            builder: (context, state) {
              if (state is PeopleSuccess) {
                final people = state.people;

                if (people.isEmpty) {
                  return const ItemCard(str1: "No people found.");
                }

                return Column(
                  children: List.generate(state.people.length, (index) {
                    final person = people[index];
                    return ItemCard(str1: person.fullName);
                  }));
              } else {
                return const LoadingWidget(
                    message: "Loading please wait."
                );
              }
            },
          ),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbench_simple_timesheet_app/core/common/widget/loading.dart';
import 'package:workbench_simple_timesheet_app/core/di/service_locator.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/item_card.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {

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
            create: (context) => sl<TasksBloc>()..add(OnInitialTasksLoadEvent()),
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksSuccess) {
                  final tasks = state.tasks;

                  if (tasks.isEmpty) {
                    return const ItemCard(str1: "No tasks found.");
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(state.tasks.length, (index) {
                        final task = tasks[index];
                        return ItemCard(str1: task.name, str2: task.description,);
                      })),
                  );
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

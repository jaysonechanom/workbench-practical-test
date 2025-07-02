import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:workbench_simple_timesheet_app/core/common/widget/loading.dart';
import 'package:workbench_simple_timesheet_app/core/di/service_locator.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/timesheet/timesheet_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/mixin/timesheet_mixin.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/views/time_entry_page.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/item_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TimesheetMixin {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value, BuildContext context) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      context.read<TimesheetBloc>().add(OnSearchEvent(value));
    });
  }

  void _onClearSearch(BuildContext context) {
    _searchController.clear();
    context.read<TimesheetBloc>().add(OnInitialTimesheetLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async  {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TimeEntryPage(isEdit: false,))
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocProvider(
            create: (context) => sl<TimesheetBloc>()..add(OnInitialTimesheetLoadEvent()),
            child: BlocBuilder<TimesheetBloc, TimesheetState>(
              builder: (context, state) {
                if (state is TimesheetSuccess) {
                  final timesheets = state.timesheet;

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(8),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (value) async {
                                    _onSearchChanged(value, context);
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    suffixIcon: _searchController.text.isNotEmpty
                                        ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () async {
                                        _onClearSearch(context);
                                      },
                                    )
                                        : null,
                                    hintText: 'Search',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(state.timesheet.isNotEmpty) ...[
                          ...List.generate(state.timesheet.length, (index) {
                            final timesheet = timesheets[index];
                            return SizedBox(
                              width: double.infinity,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                shadowColor: Colors.teal.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ${timesheet.personName ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Task: ${timesheet.taskName ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Description: ${timesheet.taskDescription ?? ""}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        'Date: ${DateFormat('MMM d, yyyy')
                                            .format(DateTime.parse(timesheet.date))} '
                                            '${parseTimeToAmOrPm(timesheet.startTime)} - '
                                            '${parseTimeToAmOrPm(timesheet.endTime)} ',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      if(timesheet.notes != null) ...[
                                        Text(
                                          'Notes: ${timesheet.notes}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child:InkWell(
                                              onTap: () async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => TimeEntryPage(
                                                          isEdit: true,
                                                          id: timesheet.id,
                                                          personId: timesheet.peopleId,
                                                          taskId: timesheet.tasksId,
                                                          date: timesheet.date,
                                                          startTime: timesheet.startTime,
                                                          endTime: timesheet.endTime,
                                                          notes: timesheet.notes,
                                                        ))
                                                );
                                              },
                                              child: const Text("Edit",
                                                style: TextStyle(color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: InkWell(
                                              onTap: () async {
                                                context.read<TimesheetBloc>()
                                                    .add(OnDeleteEvent(timesheet.id!));
                                              },
                                              child: const Text("Delete",
                                                style: TextStyle(color: Colors.red),
                                              )),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          )
                        ] else ...[
                          const ItemCard(str1: "No timesheets found.")
                        ]
                       ]),
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

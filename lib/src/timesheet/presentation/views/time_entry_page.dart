import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workbench_simple_timesheet_app/core/common/widget/loading.dart';
import 'package:workbench_simple_timesheet_app/core/di/service_locator.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/people.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/domain/entities/tasks.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/bloc/time_entry/time_entry_bloc.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/mixin/timesheet_mixin.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/views/landing_page.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/date_widget.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/dropdown_widget.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/multiline_text_widget.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/widget/time_widget.dart';

class TimeEntryPage extends StatefulWidget {
  const TimeEntryPage({super.key,
    required this.isEdit,
    this.id,
    this.personId,
    this.taskId,
    this.date,
    this.startTime,
    this.endTime,
    this.notes});

  final bool isEdit;
  final int? id;
  final int? personId;
  final int? taskId;
  final String? date;
  final String? startTime;
  final String? endTime;
  final String? notes;

  @override
  State<TimeEntryPage> createState() => _TimeEntryPageState();
}

class _TimeEntryPageState extends State<TimeEntryPage> with TimesheetMixin {
  final _formKey = GlobalKey<FormState>();
  int? selectedPersonId;
  int? selectedTaskId;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? notes;

  @override
  void initState() {
    if(widget.isEdit) {
      selectedPersonId = widget.personId;
      selectedTaskId = widget.taskId;
      date = DateTime.tryParse(widget.date ?? "");
      startTime = parseTimeStringToTimeOfDay(widget.startTime ?? "");
      endTime = parseTimeStringToTimeOfDay(widget.endTime ?? "");
      notes = widget.notes;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider(
          create: (context) =>
          sl<TimeEntryBloc>()
            ..add(OnInitialTimeEntryLoadEvent()),
          child: BlocListener<TimeEntryBloc, TimeEntryState>(
            listener: (context, state) async {
              if(state is TimeEntryError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text(state.error)),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }

              if (state is TimeEntrySubmitSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(child: Text(state.isEdit
                        ? "Successfully Updated."
                        : "Successfully Saved.")
                    ),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context);
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage())
                );

              }
            },
            child: BlocBuilder<TimeEntryBloc, TimeEntryState>(
              builder: (context, state) {
                if(state is TimeEntrySuccess
                    || state is TimeEntrySubmitting
                    || state is TimeEntryError) {

                  return Stack(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  DropdownWidget<People>(
                                    items: state.peopleList ?? [],
                                    selected: selectedPersonId != null
                                        && state.peopleList != null
                                        && state.peopleList!.isNotEmpty ? state.peopleList!.firstWhere(
                                            (e) => e.id == selectedPersonId) : null,
                                    label: "Full Name",
                                    required: true,
                                    labelBuilder: (person) => person.fullName,
                                    onChanged: (person) {
                                      setState(() {
                                        selectedPersonId = person?.id;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  DropdownWidget<Tasks>(
                                    items: state.tasksList ?? [],
                                    selected: selectedTaskId != null
                                        && state.tasksList != null
                                        && state.tasksList!.isNotEmpty ? state.tasksList!.firstWhere(
                                            (e) => e.id == selectedTaskId) : null,
                                    label: "Task Name",
                                    required: true,
                                    labelBuilder: (task) => task.name,
                                    onChanged: (task) {
                                      setState(() {
                                        selectedTaskId = task?.id;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  DateWidget(
                                    label: "Date",
                                    required: true,
                                    initialDate: date,
                                    onDateSelected: (date) {
                                      setState(() {
                                        this.date = date;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null
                                          || value.trim().isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  TimeWidget(
                                    label: "Start Time",
                                    required: true,
                                    initialTime: startTime,
                                    onTimeSelected: (time) {
                                      setState(() {
                                        startTime = time;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null
                                          || value.trim().isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  TimeWidget(
                                    label: "End Time",
                                    required: true,
                                    initialTime: endTime,
                                    onTimeSelected: (time) {
                                      setState(() {
                                        endTime = time;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null
                                          || value.trim().isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                  ),
                                  MultilineTextWidget(
                                    label: 'Notes',
                                    required: false,
                                    initialValue: notes,
                                    onChanged: (value) {
                                      setState(() {
                                        notes = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextButton(onPressed: () async {
                                if(_formKey.currentState!.validate()) {
                                  context.read<TimeEntryBloc>().add(OnSubmitEvent(
                                    id: widget.isEdit ? widget.id : null,
                                    peopleId: selectedPersonId!,
                                    taskId: selectedTaskId!,
                                    date: date!,
                                    startTime: startTime!,
                                    startTimeString: startTime!.format(context),
                                    endTime: endTime!,
                                    endTimeString: endTime!.format(context),
                                    notes: notes,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Center(child: Text('Please complete all required fields.')),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                }
                              },
                                style: ButtonStyle(
                                    elevation: WidgetStateProperty.all(0),
                                    backgroundColor:
                                    WidgetStateProperty.all(
                                        Colors.blue),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            side: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1)))), child: Text(
                                  !widget.isEdit ? 'Submit' : "Update",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (state is TimeEntrySubmitting) ...[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Container(
                            color: Colors.white,
                            child: const LoadingWidget(
                                message: "Submitting form."
                            ),
                          ),
                        )
                      ],
                    ],
                  );
                } else if (state is TimeEntryLoading) {
                  return const LoadingWidget(
                      message: "Loading form components."
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

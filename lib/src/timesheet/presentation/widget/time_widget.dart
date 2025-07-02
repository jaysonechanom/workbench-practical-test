import 'package:flutter/material.dart';
import 'package:workbench_simple_timesheet_app/core/utils/required.dart';
import 'package:workbench_simple_timesheet_app/src/timesheet/presentation/mixin/timesheet_mixin.dart';

class TimeWidget extends StatefulWidget {
  final String label;
  final TimeOfDay? initialTime;
  final ValueChanged<TimeOfDay?> onTimeSelected;
  final FormFieldValidator<String>? validator;
  final bool? required;

  const TimeWidget({
    super.key,
    required this.label,
    required this.onTimeSelected,
    this.initialTime,
    this.validator,
    this.required = false,
  });

  @override
  State<TimeWidget> createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> with TimesheetMixin {
  TextEditingController _controller = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _controller = TextEditingController(
      text: _selectedTime != null ? _formatTime(_selectedTime!) : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay time) {
    return formatTimeOfDayToAmPm(time);
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _controller.text = _formatTime(picked);
      });
      widget.onTimeSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: _selectedTime != null ? 15 : 10),
      child: TextFormField(
        controller: _controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: true,
        enableInteractiveSelection: true,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          await _pickTime(context);
        },
        validator: widget.validator,
        decoration: InputDecoration(
          label: RequiredString().isRequiredControl(widget.label, widget.required),
          suffixIcon: const Icon(Icons.access_time),
          labelStyle: const TextStyle(color: Colors.black),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}

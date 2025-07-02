import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workbench_simple_timesheet_app/core/utils/required.dart';

class DateWidget extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime?> onDateSelected;
  final FormFieldValidator<String>? validator;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final bool? required;

  const DateWidget({
    super.key,
    required this.label,
    required this.onDateSelected,
    this.initialDate,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.required = false
  });

  @override
  State<DateWidget> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DateWidget> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(
      text: _selectedDate != null
          ? _formatDate(_selectedDate!)
          : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();

    final picked = await showDialog(
      context: context,
      builder: (context) {
        DateTime? picked = _selectedDate ?? DateTime.now();

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: CalendarDatePicker(
              initialDate: _selectedDate ?? now,
              firstDate: DateTime.now(),
              lastDate: widget.lastDate ?? DateTime(now.year + 100),
              onDateChanged: (date) {
                picked = date;
                Navigator.of(context).pop(picked);
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(picked!);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: _selectedDate != null ? 15 : 10),
      child: TextFormField(
        controller: _controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        readOnly: true,
        enableInteractiveSelection: true,
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
          await _pickDate(context);
        },
        validator: widget.validator,
        decoration: InputDecoration(
          label: RequiredString().isRequiredControl(widget.label, widget.required),
          suffixIcon: const Icon(Icons.calendar_today),
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

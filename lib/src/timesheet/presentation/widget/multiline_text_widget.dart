import 'package:flutter/material.dart';
import 'package:workbench_simple_timesheet_app/core/utils/required.dart';

class MultilineTextWidget extends StatefulWidget {
  final String label;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final int minLines;
  final int maxLines;
  final bool? required;

  const MultilineTextWidget({
    super.key,
    required this.label,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.minLines = 4,
    this.maxLines = 6,
    this.required = false,
  });

  @override
  State<MultilineTextWidget> createState() => _MultilineTextWidgetState();
}

class _MultilineTextWidgetState extends State<MultilineTextWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: _controller.text.isNotEmpty ? 15 : 10),
      child: TextFormField(
        controller: _controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        keyboardType: TextInputType.multiline,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          label: RequiredString().isRequiredControl(widget.label, widget.required),
          alignLabelWithHint: true,
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

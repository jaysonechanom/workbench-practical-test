import 'package:flutter/material.dart';
import 'package:workbench_simple_timesheet_app/core/utils/required.dart';

class DropdownWidget<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) labelBuilder;
  final void Function(T?) onChanged;
  final String label;
  final FormFieldValidator<T>? validator;
  final bool? required;
  final T? selected;

  const DropdownWidget({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.onChanged,
    required this.label,
    this.validator,
    this.required = false,
    this.selected,
  });

  @override
  State<DropdownWidget<T>> createState() => _DropdownWidgetState<T>();
}

class _DropdownWidgetState<T> extends State<DropdownWidget<T>> {
  T? _selected;

  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: _selected != null ? 15 : 10),
      child: DropdownButtonFormField<T>(
        icon: const Visibility(visible: false, child: Icon(Icons.arrow_drop_down)),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: _selected,
        isExpanded: true,
        validator: widget.validator,
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(widget.labelBuilder(item)),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selected = value;
          });
          widget.onChanged(value);
        },
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        decoration: InputDecoration(
          label: RequiredString().isRequiredControl(widget.label, widget.required),
          suffixIcon: const Icon(Icons.arrow_drop_down),
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          labelStyle: const TextStyle(color: Colors.black),
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

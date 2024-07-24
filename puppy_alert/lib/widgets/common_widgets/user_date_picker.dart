import 'package:flutter/material.dart';

class UserDatePicker extends StatefulWidget {
  final ValueChanged<DateTime?>? onDateSelected;

  const UserDatePicker({super.key, this.onDateSelected});

  @override
  State<UserDatePicker> createState() => _UserDatePickerState();
}

class _UserDatePickerState extends State<UserDatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            ).then((selectedDate) {
              if (selectedDate != null) {
                setState(() {
                  _selectedDate = selectedDate;
                });
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!(selectedDate);
                }
              }
            });
          },
          child: Text(
            _selectedDate == null
                ? "날짜선택"
                : "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}",
            style: const TextStyle(
              color: Color(0xFF303030),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

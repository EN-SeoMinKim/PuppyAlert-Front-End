import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {

  DatePicker({super.key});

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
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
            }
          });
        },
        child: const Text(
          "날짜선택",
          style: TextStyle(
            color: Color(0xFF303030),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UserDatePickerCommonWidget extends StatefulWidget {
  final ValueChanged<DateTime?>? _onDateSelected;

  const UserDatePickerCommonWidget({super.key, void Function(DateTime?)? onDateSelected}) : _onDateSelected = onDateSelected;

  @override
  State<UserDatePickerCommonWidget> createState() => _UserDatePickerCommonWidgetState();
}

class _UserDatePickerCommonWidgetState extends State<UserDatePickerCommonWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                  if (widget._onDateSelected != null) {
                    widget._onDateSelected!(selectedDate);
                  }
                }
              });
            },
            child: Text(
              _selectedDate == null
                  ? "날짜선택"
                  : "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}",
              style: TextStyle(
                color: Color(0xFF303030),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class TimePickerSpinnerHostWidget extends StatefulWidget {
  final ValueChanged<DateTime?>? selectedTime;

  const TimePickerSpinnerHostWidget({super.key, this.selectedTime});

  @override
  State<TimePickerSpinnerHostWidget> createState() =>
      _TimePickerSpinnerHostWidget();
}

class _TimePickerSpinnerHostWidget extends State<TimePickerSpinnerHostWidget> {
  DateTime? _selectedTime;

  void _showTimePickerDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("시간 선택"),
            content: Container(
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: TimePickerSpinner(
                      is24HourMode: true,
                      normalTextStyle: const TextStyle(
                          fontSize: 24, color: Colors.black, height: 1.5),
                      highlightedTextStyle: const TextStyle(
                          fontSize: 30, color: Colors.orange, height: 1.5),
                      spacing: 50,
                      itemHeight: 55,
                      isForce2Digits: true,
                      onTimeChange: (time) {
                        setState(() {
                          _selectedTime = time;
                        });
                        if (widget.selectedTime != null) {
                          widget.selectedTime!(time);
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 85,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("확인"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: _showTimePickerDialog,
        child: Text(
            _selectedTime == null
                ? "시간 선택"
                : "${_selectedTime!.hour.toString().padLeft(2, '0')} : ${_selectedTime!.minute.toString().padLeft(2, '0')}",
            style: const TextStyle(color: Color(0xff8A8A8A))));
  }
}

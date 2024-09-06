import 'package:flutter/material.dart';

class CheckBoxListHostWidget extends StatefulWidget {
  final String _title;
  final List<String> _valueList;
  final _CheckBoxListHostWidgetState _childWidget =
      _CheckBoxListHostWidgetState();

  List<String> getTitleList() {
    List<bool> isCheckedList = _childWidget._isCheckedList;
    List<String> result = [];

    for (bool isChecked in isCheckedList) {
      if (isChecked) {
        result.add(_valueList[isCheckedList.indexOf(isChecked)]);
      }
    }
    return result;
  }

  CheckBoxListHostWidget(
      {super.key, required String title, required List<String> valueList})
      : _title = title,
        _valueList = valueList;

  @override
  State<CheckBoxListHostWidget> createState() => _childWidget;
}

class _CheckBoxListHostWidgetState extends State<CheckBoxListHostWidget> {
  final List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
    _isCheckedList.addAll(List<bool>.filled(widget._valueList.length, false));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._valueList.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text(widget._valueList[index]),
          activeColor: const Color(0xffFF7700),
          controlAffinity: ListTileControlAffinity.leading,
          value: _isCheckedList[index],
          onChanged: (bool? value) {
            if (value != null && value != _isCheckedList[index]) {
              setState(() {
                _isCheckedList[index] = value;
              });
            }
          },
        );
      },
    );
  }
}

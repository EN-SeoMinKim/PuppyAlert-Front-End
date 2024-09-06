import 'package:flutter/material.dart';

class CheckBoxDialogHostWidget extends StatefulWidget {
  final String _title;
  final List<String> _valueList;
  final _CheckBoxDialogHostWidgetState _childWidget =
      _CheckBoxDialogHostWidgetState();

  List<String> getSelectedValueList() {
    List<bool> isCheckedList = _childWidget._isCheckedList;
    List<String> result = [];

    for (bool isChecked in isCheckedList) {
      if (isChecked) {
        result.add(_valueList[isCheckedList.indexOf(isChecked)]);
      }
    }
    return result;
  }

  CheckBoxDialogHostWidget(
      {super.key, required String title, required List<String> valueList})
      : _title = title,
        _valueList = valueList;

  @override
  State<CheckBoxDialogHostWidget> createState() => _childWidget;
}

class _CheckBoxDialogHostWidgetState extends State<CheckBoxDialogHostWidget> {
  final List<bool> _isCheckedList = [];

  @override
  void initState() {
    super.initState();
    _isCheckedList.addAll(List<bool>.filled(widget._valueList.length, false));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget._title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: widget._valueList.map((value) {
            int index = widget._valueList.indexOf(value);
            return CheckboxListTile(
              title: Text(value),
              activeColor: const Color(0xffFF7700),
              controlAffinity: ListTileControlAffinity.leading,
              value: _isCheckedList[index],
              onChanged: (bool? newValue) {
                setState(() {
                  _isCheckedList[index] = newValue!;
                });
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인', style: TextStyle(color: Color(0xffFF7700))),
        ),
      ],
    );
  }
}

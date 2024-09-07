class RecommendMenuDTO {
  late final List<String> _valueList;
  late final String _title;
  final List<bool> _isCheckedList = [];

  RecommendMenuDTO(String title, List<String> valueList) {
    _title = title;
    _valueList = valueList;
    _isCheckedList.addAll(List<bool>.filled(_valueList.length, false));
  }

  List<String> getCheckedStringList() {
    List<String> result = [];

    for (bool isChecked in _isCheckedList) {
      if (isChecked) {
        result.add(_valueList[_isCheckedList.indexOf(isChecked)]);
      }
    }
    return result;
  }

  String get title => _title;

  List<String> get valueList => _valueList;

  List<bool> get isCheckedList => _isCheckedList;
}

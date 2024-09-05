import 'package:flutter/material.dart';

class SearchBarPuppyWidget extends StatelessWidget {
  final String _dongAddress;
  String _searchValue = '';

  SearchBarPuppyWidget({super.key, required dongAddress})
      : _dongAddress = dongAddress;

  String get searchValue => _searchValue;

  void _onSearch(String value) {
    _searchValue = value;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: [
          Container(
            color: const Color(0xffFF7700),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    _dongAddress,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            color: const Color(0xffFF7700),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: SearchBar(
                controller: searchController,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _onSearch(searchController.text);
                    },
                  ),
                ],
                hintText: '검색어를 입력하세요',
                overlayColor: const WidgetStatePropertyAll(Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

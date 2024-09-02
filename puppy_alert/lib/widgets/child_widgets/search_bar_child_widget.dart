import 'package:flutter/material.dart';

class SearchBarChildWidget extends StatelessWidget {
  final String _dongAddress;
  String _searchValue = '';

  SearchBarChildWidget({super.key, required dongAddress})
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


// class SearchBarChildWidget extends StatefulWidget {
//   final String _dongAddress;
//
//   const SearchBarChildWidget({super.key, required dongAddress})
//       : _dongAddress = dongAddress;
//
//   @override
//   State<SearchBarChildWidget> createState() => _SearchBarChildWidgetState();
// }

// class _SearchBarChildWidgetState extends State<SearchBarChildWidget> {
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//       child: Column(
//         children: [
//           Container(
//             color: const Color(0xffFF7700),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
//               child: Row(
//                 children: [
//                   const Icon(
//                     Icons.pin_drop,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//                   Text(
//                     widget._dongAddress,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: 60,
//             color: const Color(0xffFF7700),
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//               child: SearchBar(
//                 controller: _searchController,
//                 trailing: [
//                   IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: () {
//
//                     },
//                   ),
//                 ],
//                 onSubmitted: (value) {
//
//                 },
//                 hintText: '검색어를 입력하세요',
//                 overlayColor: const WidgetStatePropertyAll(Colors.orange),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

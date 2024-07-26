import 'package:flutter/material.dart';

class SearchBarChildWidget extends StatefulWidget {
  final String _address;

  const SearchBarChildWidget({super.key, required this._address});

  @override
  State<SearchBarChildWidget> createState() => _SearchBarChildWidgetState();
}

class _SearchBarChildWidgetState extends State<SearchBarChildWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        children: [
          Container(
            color: const Color(0xffFF7700),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                children: [
                  Icon(
                    Icons.pin_drop,
                    color: Colors.white,
                    size: 35,
                  ),
                  Text(
                    '$widget._address',
                    style: TextStyle(color: Colors.white, fontSize: 20, ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 60,
            color: const Color(0xffFF7700),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: SearchBar(
                leading: Icon(Icons.search),
                overlayColor: WidgetStatePropertyAll(Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

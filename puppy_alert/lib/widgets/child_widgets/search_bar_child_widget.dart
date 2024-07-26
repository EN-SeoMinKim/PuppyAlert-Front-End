import 'package:flutter/material.dart';
import 'package:puppy_alert/models/user_dto.dart';

class SearchBarChildWidget extends StatefulWidget {
  final UserDto _userDto;

  const SearchBarChildWidget({super.key, required userDto})
      : _userDto = userDto;

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
                    widget._userDto.address,
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FavoriteHostChildWidget extends StatefulWidget {
  final String _hostId, _puppyId;
  final String _recentFoodTime;
  late bool _isFavorite;

  FavoriteHostChildWidget({
    super.key,
    required String hostId,
    required String puppyId,
    required String recentFoodTime,
    required bool isFavorite,
  })  : _hostId = hostId,
        _puppyId = puppyId,
        _recentFoodTime = recentFoodTime,
        _isFavorite = isFavorite;

  @override
  State<FavoriteHostChildWidget> createState() =>
      _FavoriteHostChildWidgetState();
}

class _FavoriteHostChildWidgetState extends State<FavoriteHostChildWidget> {
  Icon _getFavoriteIcon(bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.grey,
      size: 20,
    );
  }

  void updateFavoriteHost() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/favoriteHost');
    var bodyData = json.encode({
      'hostId': widget._hostId,
      'puppyId': widget._puppyId,
    });

    if (widget._isFavorite) {
      http.post(uri,
          headers: {'Content-Type': 'application/json'}, body: bodyData);
      return;
    }
    http.delete(uri,
        headers: {'Content-Type': 'application/json'}, body: bodyData);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        height: 80,
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/image.png',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget._hostId,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget._recentFoodTime,
                  style: TextStyle(
                      fontWeight: FontWeight.w200, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
      Row(
        children: [
          IconButton(
            icon: _getFavoriteIcon(widget._isFavorite),
            onPressed: () {
              setState(() {
                widget._isFavorite = !widget._isFavorite;
                updateFavoriteHost();
              });
            },
          ),
          const SizedBox(width: 30),
        ],
      )
    ]);
  }
}

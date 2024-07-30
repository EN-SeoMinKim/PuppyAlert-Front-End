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
  late String _imageURL = '';

  @override
  void initState() {
    super.initState();
    _imageURL = '';
    _imageURL = _getImageURL(widget._hostId);
  }

  String _getImageURL(String hostId) {
    switch (hostId) {
      case "ChoSangJun":
        return 'https://avatars.githubusercontent.com/u/43038815?v=4';

      case "KwonOhSung":
        return 'https://avatars.githubusercontent.com/u/79124461?v=4';

      case "ChoHyungJun":
        return 'https://avatars.githubusercontent.com/u/1024025?v=4';

      case 'KimHyunA':
        return 'https://avatars.githubusercontent.com/u/129165742?v=4';

      case 'KimSeHyun':
        return 'https://avatars.githubusercontent.com/u/102282703?v=4';

      case 'ShinJiHun':
        return 'https://avatars.githubusercontent.com/u/82876698?v=4';

      case "ParkDaeWon":
        return 'https://avatars.githubusercontent.com/u/101173462?v=4';

      case "LimWooJin":
        return 'https://avatars.githubusercontent.com/u/25877253?v=4';

      default:
        return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN_WM3EWTjbq2QuZC7txWQP92E2VoA3SwZtg&s';
    }
  }

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
            if (_imageURL.isNotEmpty)
              ClipOval(
                child: Image.network(
                  _imageURL,
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

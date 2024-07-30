import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/favorite_host_model.dart';

class FavoriteIconChildWidget extends StatefulWidget {
  final String _puppyId, _hostId;

  const FavoriteIconChildWidget({super.key, required puppyId, required hostId})
      : _puppyId = puppyId,
        _hostId = hostId;

  @override
  State<FavoriteIconChildWidget> createState() =>
      _FavoriteIconChildWidgetState();
}

class _FavoriteIconChildWidgetState extends State<FavoriteIconChildWidget> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _initIsFavorite();
  }

  void _initIsFavorite() async {
    _isFavorite = false;
    http.Response response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/favoriteHost?puppyId=${widget
            ._puppyId}'));
    List<FavoriteHostModel> hostList = jsonDecode(response.body).map<FavoriteHostModel>((json) => FavoriteHostModel.fromJson(json)).toList();

    for (var host in hostList) {
      if (host.hostId == widget._hostId) {
        setState(() {
          _isFavorite = true;
        });
        break;
      }
    }
  }

  void updateFavoriteHost() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/favoriteHost');
    var bodyData = json.encode({
      'hostId': widget._hostId,
      'puppyId': widget._puppyId,
    });

    if (_isFavorite) {
      http.post(uri,
          headers: {'Content-Type': 'application/json'}, body: bodyData);
      return;
    }
    http.delete(uri,
        headers: {'Content-Type': 'application/json'}, body: bodyData);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        color: _isFavorite ? Colors.red : Colors.grey,
        size: 20,
      ),
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
          updateFavoriteHost();
        });
      },
    );
  }
}

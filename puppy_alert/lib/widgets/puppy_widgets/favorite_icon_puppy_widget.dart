import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/favorite_host_model.dart';

class FavoriteIconPuppyWidget extends StatefulWidget {
  final String _puppyId, _hostId;

  const FavoriteIconPuppyWidget({super.key, required puppyId, required hostId})
      : _puppyId = puppyId,
        _hostId = hostId;

  @override
  State<FavoriteIconPuppyWidget> createState() =>
      _FavoriteIconPuppyWidgetState();
}

class _FavoriteIconPuppyWidgetState extends State<FavoriteIconPuppyWidget> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _initIsFavorite();
  }

  void _initIsFavorite() async {
    http.Response response = await http.get(Uri.parse(
        '${dotenv.get('BASE_URL')}/puppy/favoriteHost?puppyId=${widget._puppyId}'));
    List<FavoriteHostModel> hostList =
        jsonDecode(utf8.decode(response.bodyBytes))
            .map<FavoriteHostModel>((json) => FavoriteHostModel.fromJson(json))
            .toList();

    for (var host in hostList) {
      if (host.hostId == widget._hostId) {
        setState(() {
          _isFavorite = true;
        });
        break;
      }
    }
  }

  void _updateFavoriteHost() {
    Uri uri = Uri.parse('${dotenv.get('BASE_URL')}/puppy/favoriteHost');
    final bodyData = json.encode({
      'hostId': widget._hostId,
      'puppyId': widget._puppyId,
    });

    if (_isFavorite) {
      http.post(uri,
          headers: {'Content-Type': 'application/json'}, body: bodyData);
    } else {
      http.delete(uri,
          headers: {'Content-Type': 'application/json'}, body: bodyData);
    }
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
          _updateFavoriteHost();
        });
      },
    );
  }
}

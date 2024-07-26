import 'package:flutter/material.dart';

class FavoriteHostChildWidget extends StatefulWidget {
  final String _hostId;
  final String _recentFoodTime;
  late bool _isFavorite;

  FavoriteHostChildWidget({
    super.key,
    required String hostId,
    required String recentFoodTime,
    required bool isFavorite,
  })  : _hostId = hostId,
        _recentFoodTime = recentFoodTime,
        _isFavorite = isFavorite;

  @override
  State<FavoriteHostChildWidget> createState() =>
      _FavoriteHostChildWidgetState();
}

class _FavoriteHostChildWidgetState
    extends State<FavoriteHostChildWidget> {
  Icon _getFavoriteIcon(bool isFavorite) {
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : Colors.grey,
      size: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              });
            },
          ),
          const SizedBox(width: 30),
        ],
      )
    ]);
  }
}

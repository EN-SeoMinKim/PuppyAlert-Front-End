import 'package:flutter/material.dart';
import 'package:puppy_alert/widgets/child_widgets/favorite_icon_child_widget.dart';

class FavoriteHostChildWidget extends StatelessWidget {
  final String _hostId, _puppyId;
  final String _recentFoodTime;

  const FavoriteHostChildWidget({
    super.key,
    required String hostId,
    required String puppyId,
    required String recentFoodTime,
    required bool isFavorite,
  })
      : _hostId = hostId,
        _puppyId = puppyId,
        _recentFoodTime = recentFoodTime;

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
                  _hostId,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _recentFoodTime,
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
          FavoriteIconChildWidget(
              puppyId: _puppyId, hostId: _hostId),
          const SizedBox(width: 30),
        ],
      )
    ]);
  }
}

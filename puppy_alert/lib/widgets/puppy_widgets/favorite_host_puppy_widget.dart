import 'package:flutter/material.dart';
import 'package:puppy_alert/models/favorite_host_model.dart';
import 'package:puppy_alert/widgets/puppy_widgets/favorite_icon_puppy_widget.dart';

class FavoriteHostPuppyWidget extends StatelessWidget {
  final String _puppyId;
  final FavoriteHostModel _favoriteHostModel;

  const FavoriteHostPuppyWidget({
    super.key,
    required String puppyId,
    required FavoriteHostModel favoriteHostModel,
  })  : _puppyId = puppyId,
        _favoriteHostModel = favoriteHostModel;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        height: 80,
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                _favoriteHostModel.hostProfileImageURL,
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
                  _favoriteHostModel.hostNickName,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _favoriteHostModel.recentFoodTime,
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
          FavoriteIconPuppyWidget(puppyId: _puppyId, hostId: _favoriteHostModel.hostId),
          const SizedBox(width: 30),
        ],
      )
    ]);
  }
}

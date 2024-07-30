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
  })  : _hostId = hostId,
        _puppyId = puppyId,
        _recentFoodTime = recentFoodTime;

  String _getImageURL() {
    switch (_hostId) {
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

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        height: 80,
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                _getImageURL(),
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
          FavoriteIconChildWidget(puppyId: _puppyId, hostId: _hostId),
          const SizedBox(width: 30),
        ],
      )
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:puppy_alert/models/food_model.dart';
import 'package:puppy_alert/widgets/child_widgets/favorite_icon_child_widget.dart';

class FoodCommonWidget extends StatelessWidget {
  final String _userId;
  final FoodModel _foodModel;

  FoodModel get foodModel => _foodModel;

  const FoodCommonWidget({
    super.key,
    required String userId,
    required FoodModel foodModel,
  })  : _userId = userId,
        _foodModel = foodModel;

  Color _getBackgroundColor() {
    if (_foodModel.status == 'MATCHED') {
      return Colors.grey[200]!;
    }
    return const Color(0xffFFFAE1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                _foodModel.imageURL,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _foodModel.menuName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 30,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_foodModel.hostNickName),
                    FavoriteIconChildWidget(
                        puppyId: _userId, hostId: _foodModel.hostId),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(_foodModel.time),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  _foodModel.status,
                  style: const TextStyle(
                    color: Color(0xff7D6600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

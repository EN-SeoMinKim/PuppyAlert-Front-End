import 'package:flutter/material.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import 'package:puppy_alert/screens/host_screens/recipe_host_screen.dart';

class RecommendMenuWidget extends StatelessWidget {
  final RecommendMenuModel _recommendMenuModel;

  const RecommendMenuWidget(
      {super.key, required RecommendMenuModel recommendMenuModel})
      : _recommendMenuModel = recommendMenuModel;

  @override
  Widget build(BuildContext context) {
    List<Icon> starList = [];
    for (int i = 0; i < _recommendMenuModel.difficulty; i++) {
      starList.add(const Icon(Icons.star, color: Colors.yellow));
    }
    for (int i = _recommendMenuModel.difficulty; i < 5; i++) {
      starList.add(const Icon(Icons.star_border, color: Colors.yellow));
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                _recommendMenuModel.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return RecipeHostScreen(
                      recommendMenuWidget: RecommendMenuWidget(
                          recommendMenuModel: _recommendMenuModel));
                }));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_recommendMenuModel.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis)),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text('난이도',
                            style: TextStyle(fontSize: 15, color: Colors.orange)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: starList,
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 40,
                      child: Text(_recommendMenuModel.description,
                          style: const TextStyle(
                            fontSize: 13,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

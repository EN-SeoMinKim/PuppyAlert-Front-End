import 'package:flutter/material.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import 'package:puppy_alert/screens/host_screens/recipe_host_screen.dart';

class RecommendMenuWidget extends StatelessWidget {
  final RecommendMenuModel _recommendMenuModel;
  final bool _isRecommend;

  const RecommendMenuWidget(
      {super.key,
        required RecommendMenuModel recommendMenuModel,
        bool isRecommend = true})
      : _recommendMenuModel = recommendMenuModel,
        _isRecommend = isRecommend;

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
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 3), // changes position of shadow to bottom
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: SizedBox(
                  height: 110,
                  child: Image.network(
                    _recommendMenuModel.url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (!_isRecommend) {
                    return;
                  }

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RecipeHostScreen(
                        recommendMenuModel: _recommendMenuModel);
                  }));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                              style: TextStyle(
                                  fontSize: 15, color: Colors.orange)),
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
      ),
    );
  }
}
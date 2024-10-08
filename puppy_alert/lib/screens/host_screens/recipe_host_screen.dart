import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:puppy_alert/models/recommend_menu_model.dart';
import 'package:puppy_alert/widgets/host_widgets/recommend_menu_widget.dart';
import 'package:http/http.dart' as http;

class RecipeHostScreen extends StatelessWidget {
  final RecommendMenuModel _recommendMenuModel;

  const RecipeHostScreen(
      {super.key, required RecommendMenuModel recommendMenuModel})
      : _recommendMenuModel = recommendMenuModel;

  Future<List<String>> _fetchRecipe() async {
    final List<String> recipeList = [];
    final response = await http.get(Uri.parse(
        '${dotenv.env['BASE_URL']}/openai/recipe?menuName=${_recommendMenuModel.title}'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load recipe');
    }

    final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    recipeList.addAll([
      jsonData['step1'],
      jsonData['step2'],
      jsonData['step3'],
      jsonData['step4'],
      jsonData['step5']
    ]);

    return recipeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레시피',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          RecommendMenuWidget(recommendMenuModel: _recommendMenuModel, isRecommend: false,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: _fetchRecipe(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16.0),
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [Colors.yellow, Colors.purpleAccent],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              title: Text(
                                snapshot.data![index],
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
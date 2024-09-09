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
          RecommendMenuWidget(recommendMenuModel: _recommendMenuModel),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: FutureBuilder(
                    future: _fetchRecipe(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Column(
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i++)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${i+1}. ${snapshot.data![i]}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        );
                      }
                    })),
          ),
        ],
      ),
    );
  }
}

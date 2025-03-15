import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeService {
  final String apiUrl = "https://api.example.com/recipes";

  Future<List<Recipe>> getRecipes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((data) => Recipe.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}

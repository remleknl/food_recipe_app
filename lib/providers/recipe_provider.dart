import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  Future<void> fetchRecipes() async {
    try {
      _recipes = await _recipeService.getRecipes();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}

import 'package:flutter/material.dart';
import '../services/recipe_service.dart';
import '../models/recipe.dart';

class HomeScreen extends StatelessWidget {
  final RecipeService recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Recipes')),
      body: FutureBuilder<List<Recipe>>(
        future: recipeService.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recipes found.'));
          } else {
            List<Recipe> recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipes[index].title),
                  subtitle: Text(recipes[index].description),
                );
              },
            );
          }
        },
      ),
    );
  }
}

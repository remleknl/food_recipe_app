import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Logout functionality
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: recipeProvider.fetchRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || recipeProvider.recipes.isEmpty) {
            return Center(child: Text('No recipes found.'));
          } else {
            List<Recipe> recipes = recipeProvider.recipes;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(recipes[index].title),
                  subtitle: Text(recipes[index].description),
                  leading: Image.network(recipes[index].imageUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}

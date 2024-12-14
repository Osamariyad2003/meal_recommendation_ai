import 'package:flutter/material.dart';
import '../Screens/gemini_screen.dart';
import '../bloc/suggested_recipe_state.dart';
import 'card_content.dart';
import 'ingredientList.dart';
import 'instructionList.dart';

class RecipeDetails extends StatelessWidget {
  final SuggestedRecipeSuccess state;

  const RecipeDetails( {required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = state.suggestedRecipe;

    return Padding(
      padding:  EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 20),
           SectionHeader(title: 'Meal Name'),
          CardContent(content: recipe.name.toString()),
           SizedBox(height: 10),
           SectionHeader(title: 'Description'),
          CardContent(content: recipe.summary.toString()),
           SizedBox(height: 10),
           SectionHeader(title: 'Ingredients'),
          IngredientList(ingredients: recipe.ingredients),
           SizedBox(height: 10),
           SectionHeader(title: 'Instructions'),
          InstructionList(instructions: recipe.mealSteps),
          SizedBox(height: 20,)

        ],
      ),
    );
  }
}

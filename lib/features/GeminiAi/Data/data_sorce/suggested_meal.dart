import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:http/http.dart' as http;

import '../../../../core/models/meal.dart';
import '../models/ImageModel.dart';
import '../models/suggested_meal_model.dart';

class RecipeRemoteDatasource {
  final String api_key = 'AIzaSyCpE7wK21sbWLZRAhxWalbyBVvAzoPSsZs';
  final gemini = GenerativeModel(
    model: 'gemini-1.5-pro',
    apiKey: "AIzaSyCpE7wK21sbWLZRAhxWalbyBVvAzoPSsZs",
    generationConfig: GenerationConfig(
      temperature: 0.9,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
  );

  String extractJson(String responseText) {
    final jsonStart = responseText.indexOf('{');
    final jsonEnd = responseText.lastIndexOf('}');
    if (jsonStart == -1 || jsonEnd == -1) {
      throw Exception('JSON data not found in the response');
    }
    return responseText.substring(jsonStart, jsonEnd + 1);
  }

  Future<AIMeal> getRecipeSuggestions(String ingredients) async {
    try {
      var prompt = '''
      I need a recipe suggestion for breakfast/lunach/dinner in JSON format that matches the structure of the model I provided below. The JSON should include the following sections: 
      - `name` (recipe name),
      - `meal_type` (type of meal),
      - `rating` (rating of the recipe),
      - `cook_time` (time to cook in minutes),
      - `serving_size` (number of servings),
      - `summary` (includes a description and a list of nutritional information),
      - `(ingredients)` (list of ingredients with names,image_url,and quantity in pieces) ,
      - `meal_steps` (list of cooking instructions).
      Return the meal name based on ${ingredients}

      Return the response strictly in JSON format without any additional text or comments.
      Ensure the JSON response strictly adheres to the JSON standard:
- All keys and string values must be enclosed in double quotes.
- Fractions or mixed strings like `1/2` must be quoted as `"1/2"`.
      ''';

      final content = [Content.text(prompt)];

      final response = await gemini.generateContent(content);

      final jsonString = extractJson(response.text!.trim());
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      void printLongText(String text) {
        final pattern = RegExp('.{1,800}');
        for (final match in pattern.allMatches(text)) {
          print(match.group(0));
        }
      }

      printLongText(jsonString);
      return AIMeal.fromJson(jsonMap);
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching recipe suggestions: $e');
    }
  }

  ///Fetch Dish Name Image (Ahmed)
  Future<ImageModel> getDishImage(String dishName) async {
    const String host = 'api.spoonacular.com';
    const String path = '/recipes/complexSearch';

    Uri url = Uri.https(
      host,
      path,
      {
        'apiKey': 'e2a21c9bc1754ab9bd830d5d65bf7a7d',
        'query': dishName,
        'addRecipeInformation': 'false',
      },
    );

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return ImageModel.fromJson(json);
      } else {
        throw Exception(
            'Failed to fetch dish image: ${response.statusCode}, ${response
                .reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching dish image: $e');
    }
  }

  Future<void> saveSuggestedMealToFirestore(String ingredients) async {
    try {
      // Step 1: Fetch the suggested recipe
      final AIMeal suggestedMeal = await getRecipeSuggestions(ingredients);

      // Step 2: Fetch an image for the meal
      final ImageModel dishImage = await getDishImage(suggestedMeal.name);

      // Step 3: Validate and convert AIMeal to Meal
      final Meal meal = Meal(
        name: suggestedMeal.name,
        dishName: suggestedMeal.name,
        // Default to the name if dishName is not available
        mealType: suggestedMeal.mealType.join(" , "),
        rating: suggestedMeal.rating,
        cookTime: suggestedMeal.cookTime,
        servingSize: suggestedMeal.servingSize,
        summary: MealSummary(
          summary: suggestedMeal.summary,
          nutrations: [
          ], // Handle this gracefully if no nutritional data is provided
        ),
        ingredients: suggestedMeal.ingredients.isNotEmpty
            ? suggestedMeal.ingredients.map((ingredient) {
          return MealIngredient(
            name: ingredient.name,
            imageUrl: ingredient.image,
            pieces: int.tryParse(
              ingredient.quantity.replaceAll(RegExp(r'\D'), ''),
            ) ?? 0,
          );
        }).toList()
            : [],
        mealSteps: suggestedMeal.mealSteps.isNotEmpty
            ? suggestedMeal.mealSteps
            : [],
        imageUrl: dishImage.results != null && dishImage.results!.isNotEmpty
            ? dishImage.results!.first.image // Set the first image URL
            : 'https://default-image-url.com/default.jpg', // Fallback if no images are available
      );

      // Step 4: Add the meal to Firestore
      await FirebaseFirestore.instance.collection('meals').add(meal.toJson());

      print('Suggested meal successfully added to Firestore!');
    } catch (e) {
      print('Error saving suggested meal to Firestore: $e');
      throw Exception('Failed to save suggested meal: $e');
    }
  }

}
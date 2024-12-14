import 'package:cloud_firestore/cloud_firestore.dart';


const int mealAdapterId = 0;
const int mealSummaryAdapterId = 1;
const int mealNutritionAdapterId = 2;
const int mealIngredientAdapterId = 3;

class Meal {
  String? id;
  String? imageUrl;
  String? name;
  String? dishName;
  String? mealType;
  double? rating;
  int? cookTime;
  int? servingSize;
  MealSummary? summary;
  List<MealIngredient>? ingredients;
  List<String>? mealSteps;
  bool isFavourite;

  Meal({
    this.id,
    this.imageUrl,
    this.name,
    this.dishName,
    this.mealType,
    this.rating,
    this.cookTime,
    this.servingSize,
    this.summary,
    this.ingredients,
    this.mealSteps,
    this.isFavourite = false,
  });

  factory Meal.fromDocument(DocumentSnapshot doc) {
    return Meal(
      dishName: doc['dish_name'] ?? '',  // Ensure this field exists in your Firestore document
      imageUrl: doc['image_url'] ?? '',  // Ensure the image URL field exists
      isFavourite: doc['is_favourite'] ?? false,  // Default to false if not present
      ingredients: (doc['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => MealIngredient.fromJson(ingredient))
          .toList() ??
          [],
    );
  }

  // fromJson constructor
  Meal.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        imageUrl = json["image_url"],
        name = json["name"],
        dishName = json["dish_name"],
        mealType = json["meal_type"],
        rating = json["rating"] != null ? json["rating"].toDouble() : null,
        cookTime = json["cook_time"],
        servingSize = json["serving_size"],
        summary = json["summary"] != null
            ? MealSummary.fromJson(json["summary"])
            : null,
        ingredients = json["ingredients"] != null
            ? (json["ingredients"] as List)
            .map((item) => MealIngredient.fromJson(item))
            .toList()
            : null,
        mealSteps = json["meal_steps"] != null
            ? List<String>.from(json["meal_steps"])
            : null,
        isFavourite = json["is_favourite"] ?? false;

  // toJson method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = imageUrl;
    data['name'] = name;
    data['dish_name'] = dishName;
    data['meal_type'] = mealType;
    data['rating'] = rating;
    data['cook_time'] = cookTime;
    data['serving_size'] = servingSize;
    if (summary != null) {
      data['summary'] = summary?.toJson();
    }
    if (ingredients != null) {
      data['ingredients'] = ingredients?.map((e) => e.toJson()).toList();
    }
    data['meal_steps'] = mealSteps;
    data['is_favourite'] = isFavourite;
    return data;
  }
}



class MealSummary {
  String? summary;
  List<MealNutrition>? nutrations;

  MealSummary({this.summary, this.nutrations});

  MealSummary.fromJson(Map<String, dynamic> json)
      : summary = json["summary"],
        nutrations = json["nutrations"] != null
            ? (json["nutrations"] as List)
            .map((item) => MealNutrition.fromJson(item))
            .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['summary'] = summary;
    if (nutrations != null) {
      data['nutrations'] = nutrations?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class MealIngredient {
  String? name;
  String? imageUrl;
  int? pieces;

  MealIngredient({this.name, this.imageUrl, this.pieces});

  MealIngredient.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        imageUrl = json["imageUrl"],
        pieces = json["pieces"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['pieces'] = pieces;
    return data;
  }
}

class MealNutrition {
  int? quantityInGrams;
  String? nutrientName;

  MealNutrition({this.quantityInGrams, this.nutrientName});

  MealNutrition.fromJson(Map<String, dynamic> json)
      : quantityInGrams = json["quantity_in_grams"],
        nutrientName = json["nutrient_name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity_in_grams'] = quantityInGrams;
    data['nutrient_name'] = nutrientName;
    return data;
  }
}

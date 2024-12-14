class AIMeal {
  final String name;
  final List<String> mealType;
  final double rating;
  final int cookTime;
  final int servingSize;
  final String summary;
  final List<Ingredient> ingredients;
  final List<String> mealSteps;

  AIMeal({
    required this.name,
    required this.mealType,
    required this.rating,
    required this.cookTime,
    required this.servingSize,
    required this.summary,
    required this.ingredients,
    required this.mealSteps,
  });

  factory AIMeal.fromJson(Map<String, dynamic> json) {
    return AIMeal(
      name: json['name'] as String,
      mealType: json['meal_type'] is List
          ? List<String>.from(json['meal_type'])
          : [json['meal_type'].toString()], // ✅ Ensure always a list

      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,

      cookTime: json['cook_time'] is int
          ? json['cook_time'] as int
          : int.tryParse(json['cook_time'].toString()) ?? 0,

      servingSize: json['serving_size'] is int
          ? json['serving_size'] as int
          : int.tryParse(json['serving_size'].toString()) ?? 1,

      summary: (json['summary'] is Map<String, dynamic> && json['summary']?['description'] != null)
          ? json['summary']['description'].toString()  // ✅ Ensure always String
          : "No description available",

      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((ingredient) => Ingredient.fromJson(ingredient))
          .toList() ??
          [],

      mealSteps: json['meal_steps'] is List
          ? List<String>.from(json['meal_steps'])
          : [json['meal_steps'].toString()], // ✅ Ensure always a list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'meal_type': mealType,
      'rating': rating,
      'cook_time': cookTime,
      'serving_size': servingSize,
      'summary': summary,
      'ingredients': ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'meal_steps': mealSteps,
    };
  }
}

class Ingredient {
  final String name;
  final String image;
  final String quantity;

  Ingredient({
    required this.name,
    required this.image,
    required this.quantity,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String,
      image: json['image_url'] as String,
      quantity: json['quantity'].toString(), // ✅ Converts int to String if needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'quantity': quantity,
    };
  }
}

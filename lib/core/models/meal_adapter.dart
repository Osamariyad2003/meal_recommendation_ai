import 'package:hive/hive.dart';
import 'package:meal_recommendation_ai/core/models/meal.dart';

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 0;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      id: fields[0] as String?,
      imageUrl: fields[1] as String?,
      name: fields[2] as String?,
      dishName: fields[3] as String?,
      cookTime: fields[6] as int?,
      servingSize: fields[7] as int?,
      summary: fields[8] as MealSummary?,
      ingredients: (fields[9] as List?)?.cast<MealIngredient>(),
      mealSteps: (fields[10] as List?)?.cast<String>(),
      mealType: fields[4] as String?,
      rating: fields[5] as double?,
      isFavourite: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.dishName)
      ..writeByte(4)
      ..write(obj.mealType)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.cookTime)
      ..writeByte(7)
      ..write(obj.servingSize)
      ..writeByte(8)
      ..write(obj.summary)
      ..writeByte(9)
      ..write(obj.ingredients)
      ..writeByte(10)
      ..write(obj.mealSteps)
      ..writeByte(11)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MealAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class MealSummaryAdapter extends TypeAdapter<MealSummary> {
  @override
  final int typeId = 1;

  @override
  MealSummary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealSummary(
      summary: fields[0] as String,
      nutrations: (fields[1] as List).cast<MealNutrition>(),
    );
  }

  @override
  void write(BinaryWriter writer, MealSummary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.summary)
      ..writeByte(1)
      ..write(obj.nutrations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MealSummaryAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class MealNutritionAdapter extends TypeAdapter<MealNutrition> {
  @override
  final int typeId = 2;

  @override
  MealNutrition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealNutrition(
      quantityInGrams: fields[0] as int,
      nutrientName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MealNutrition obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.quantityInGrams)
      ..writeByte(1)
      ..write(obj.nutrientName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MealNutritionAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}

class MealIngredientAdapter extends TypeAdapter<MealIngredient> {
  @override
  final int typeId = 3;

  @override
  MealIngredient read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealIngredient(
      imageUrl: fields[1] as String,
      name: fields[0] as String,
      pieces: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MealIngredient obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(2)
      ..write(obj.pieces);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MealIngredientAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
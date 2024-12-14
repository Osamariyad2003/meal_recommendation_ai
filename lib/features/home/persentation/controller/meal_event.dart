import '../../../../core/models/meal.dart';

abstract class MealEvent {}

class FetchMealsEvent extends MealEvent {}

class SearchedMealsEvent extends MealEvent {
  final String searchQuery;
  SearchedMealsEvent(this.searchQuery);
}

class FilterListBottomSheetEvent extends MealEvent {
  final String? mealType;
  final String? mealTime;
  final num? numOfIngredients;
  FilterListBottomSheetEvent({
    this.mealType,
    this.mealTime,
    this.numOfIngredients,
  });
}

class AddFavMealEvent extends MealEvent {
  final Meal meal;
  AddFavMealEvent(this.meal);
}

class RemoveFavMealEvent extends MealEvent {
  final Meal meal;
  RemoveFavMealEvent(this.meal);
}

class RemoveMealFromFirestoreEvent extends MealEvent {
  final Meal meal;
  RemoveMealFromFirestoreEvent(this.meal);
}

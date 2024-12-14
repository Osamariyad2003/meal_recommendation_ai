


import '../../../../core/models/meal.dart';
import '../add_meal_repository.dart';

class MealUseCase {
  final AddMealRepository addMealRepository;


  MealUseCase(this.addMealRepository,);

  Future<List<Meal>> fetchUserMeals(String userId) async {
    return await addMealRepository.getMeals(userId);
  }

  Future<void> addMeal(String userId, Meal meal) async {
    await addMealRepository.addMeal(userId, meal);
  }

  Future<void> deleteMeal(String userId, String mealId) async {
    await addMealRepository.deleteMeal(userId, mealId);
  }
}

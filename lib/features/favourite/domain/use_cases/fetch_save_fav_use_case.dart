


import '../../../../core/models/meal.dart';
import '../repositories/fetch_save_fav_repository.dart';

class FetchAndSaveFavMealsUseCase {
  final FetchAndSaveFavMealsRepository mealRepository;

  FetchAndSaveFavMealsUseCase(this.mealRepository);

  Future<List<Meal>> call() async {
    return await mealRepository.fetchAndSaveFavMeals();
  }
}

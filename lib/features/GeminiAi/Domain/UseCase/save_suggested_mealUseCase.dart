import '../../Data/Repo/recipeRepo.dart';

class   SaveRecipeSuggestionUseCase {
  final RecipeRepository recipeRepository;

  SaveRecipeSuggestionUseCase(this.recipeRepository);

  Future<void> call(String ingredients) {
    return recipeRepository.saveSuggestedMealToFirestore(ingredients);
  }
}
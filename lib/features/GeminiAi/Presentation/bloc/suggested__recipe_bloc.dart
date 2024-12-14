import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/features/GeminiAi/Domain/UseCase/save_suggested_mealUseCase.dart';
import 'package:meal_recommendation_ai/features/GeminiAi/Presentation/bloc/suggested-recipe_event.dart';
import 'package:meal_recommendation_ai/features/GeminiAi/Presentation/bloc/suggested_recipe_state.dart';


import '../../Domain/UseCase/getRecipeSuggestionUseCase.dart';

class SuggestedRecipeBloc extends Bloc<SuggestedRecipeEvent, SuggestedRecipeState> {
  final GetRecipeSuggestionUseCase getRecipeSuggestionUseCase;
  final SaveRecipeSuggestionUseCase saveRecipeSuggestionUseCase;


  SuggestedRecipeBloc(this.getRecipeSuggestionUseCase, this.saveRecipeSuggestionUseCase) : super(SuggestedRecipeInitial()) {
    on<FetchSuggestedRecipeEvent>(_onFetchSuggestedRecipe);
    on<SaveSuggestedRecipeEvent>(_onSaveSuggestedRecipe);
  }

  Future<void> _onFetchSuggestedRecipe(
      FetchSuggestedRecipeEvent event,
      Emitter<SuggestedRecipeState> emit,
      ) async {
    emit(SuggestedRecipeLoading());
    try {
      final recipe = await getRecipeSuggestionUseCase(event.ingredient);
      final image = await getRecipeSuggestionUseCase.callGetImage(recipe.name);
      emit(SuggestedRecipeSuccess( recipe, image));
    } catch (e) {
      emit(SuggestedRecipeError(errorMessage: e.toString()));
    }
  }

  Future<void> _onSaveSuggestedRecipe(
      SuggestedRecipeEvent event,
      Emitter<SuggestedRecipeState> emit,
      ) async {
    try {
      final saveEvent = event as SaveSuggestedRecipeEvent; // Explicit cast
      await saveRecipeSuggestionUseCase(saveEvent.ingredient);
      emit(SaveSuggestedRecipeSuccess());
    } catch (e) {
      emit(SuggestedRecipeError(errorMessage: e.toString()));
    }
  }

}

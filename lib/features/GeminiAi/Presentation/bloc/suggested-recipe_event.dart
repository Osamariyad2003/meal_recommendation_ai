abstract class SuggestedRecipeEvent {}

class FetchSuggestedRecipeEvent extends SuggestedRecipeEvent {
  final String ingredient;

  FetchSuggestedRecipeEvent(this.ingredient);
}

class SaveSuggestedRecipeEvent extends SuggestedRecipeEvent {
  final String ingredient;
  SaveSuggestedRecipeEvent(this.ingredient);
}

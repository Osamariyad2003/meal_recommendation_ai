import 'package:bloc/bloc.dart';
import '../../../../core/models/meal.dart';
import '../../domain/usecase/add_meal_to_fav.dart';
import '../../domain/usecase/fetch_meals.dart';
import '../../domain/usecase/firestore_usecase.dart';
import '../../domain/usecase/remove_meal.dart';
import '../../domain/usecase/remove_meal_from_fireStore.dart';
import 'meal_event.dart';
import 'meal_state.dart';


class MealBloc extends Bloc<MealEvent, MealState> {
  final FetchMeals fetchMealsUseCase;
  final AddMealToFav addMealToFavoritesUseCase;
  final RemoveMeal removeFavoriteMealUseCase;
  final UpdateIsFavInFirestore updateIsFavUseCase;
  final RemoveMealFromFirestore removeMealFromFirestore;

  MealBloc({
    required this.fetchMealsUseCase,
    required this.addMealToFavoritesUseCase,
    required this.removeFavoriteMealUseCase,
    required this.updateIsFavUseCase,
    required this.removeMealFromFirestore,
  }) : super(MealInitial()) {
    on<FetchMealsEvent>(_onFetchMeals);
    on<SearchedMealsEvent>(_onSearchedMeals);
    on<FilterListBottomSheetEvent>(_onFilterListBottomSheet);
    on<AddFavMealEvent>(_onAddFavMeal);
    on<RemoveFavMealEvent>(_onRemoveFavMeal);
    on<RemoveMealFromFirestoreEvent>(_onRemoveMealFromFirestore);
  }

  List<Meal> myMeals = [];

  // Fetch Meals logic
  Future<void> _onFetchMeals(FetchMealsEvent event, Emitter<MealState> emit) async {
    try {
      emit(MealLoading());
      myMeals = await fetchMealsUseCase();
      emit(MealLoaded(myMeals));
    } catch (e) {
      emit(MealError('Error loading meals'));
    }
  }

  // Search Meals logic
  void _onSearchedMeals(SearchedMealsEvent event, Emitter<MealState> emit) {
    if (event.searchQuery.isEmpty) {
      emit(MealLoaded(myMeals));
    } else {
      final filteredList = myMeals
          .where((meal) =>
      meal.name?.toLowerCase().contains(event.searchQuery.toLowerCase()) ?? false)
          .toList();
      emit(MealLoaded(filteredList));
    }
  }

  // Filter Meals logic
  void _onFilterListBottomSheet(FilterListBottomSheetEvent event, Emitter<MealState> emit) {
    final isFilterEmpty = (event.mealType?.isEmpty ?? true) &&
        (event.mealTime?.isEmpty ?? true) &&
        event.numOfIngredients == null;
    if (isFilterEmpty) {
      emit(MealLoaded(myMeals));
      return;
    }

    final filteredList = myMeals.where((meal) {
      final matchesMealType = event.mealType == null || meal.mealType == event.mealType;
      final matchesMealTime =
          event.mealTime == null || meal.cookTime.toString() == event.mealTime;
      final matchesNumOfIngredients = event.numOfIngredients == null ||
          meal.ingredients?.length == event.numOfIngredients;
      return matchesMealType && matchesMealTime && matchesNumOfIngredients;
    }).toList();
    emit(MealLoaded(filteredList));
  }

  // Add Meal to Favorites logic
  Future<void> _onAddFavMeal(AddFavMealEvent event, Emitter<MealState> emit) async {
    try {
      await updateIsFavInFireStore(event.meal.dishName!, event.meal.isFavourite);
      await addMealToFavoritesUseCase(event.meal);
      emit(MealLoaded([...myMeals, event.meal]));
    } catch (e) {
      print("Failed to add meal to favorites: $e");
    }
  }

  // Remove Meal from Favorites logic
  Future<void> _onRemoveFavMeal(RemoveFavMealEvent event, Emitter<MealState> emit) async {
    try {
      await updateIsFavInFireStore(event.meal.dishName!, event.meal.isFavourite);
      await removeFavoriteMealUseCase(event.meal);
      emit(MealLoaded([...myMeals]));
    } catch (e) {
      print("Failed to remove meal from favorites: $e");
    }
  }

  // Remove Meal from Firestore logic
  Future<void> _onRemoveMealFromFirestore(RemoveMealFromFirestoreEvent event, Emitter<MealState> emit) async {
    try {
      await removeMealFromFirestore(event.meal.dishName!);
      emit(MealLoaded([...myMeals]));
    } catch (e) {
      print("Failed to remove meal from firestore: $e");
    }
  }

  // Update the favorite status in Firestore
  Future<void> updateIsFavInFireStore(String dishName, bool isFav) async {
    try {
      await updateIsFavUseCase(dishName, isFav);
      print("Is Fav updated successfully in FireStore");
    } catch (e) {
      print("Failed to update is_favourite: $e");
    }
  }
}


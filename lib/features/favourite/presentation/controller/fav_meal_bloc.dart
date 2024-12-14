

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/use_cases/fetch_save_fav_use_case.dart';
import 'fav_meal_event.dart';
import 'fav_meal_state.dart';

class FavMealBloc extends Bloc<FavMealEvent,FavMealState> {
  final FetchAndSaveFavMealsUseCase fetchAndSaveFavMealsUseCase;

  FavMealBloc(this.fetchAndSaveFavMealsUseCase) : super(FavMealInitial()) {
    on<FetchAndSaveFavMealsEvent>(_onFetchAndSaveFavMeals);
  }

  Future<void> _onFetchAndSaveFavMeals(
      FetchAndSaveFavMealsEvent event, Emitter<FavMealState> emit) async {
    try {
      emit(FavMealLoading());

      final favMeals = await fetchAndSaveFavMealsUseCase();

      emit(FavMealLoaded(favMeals));
    } catch (e) {
      emit(const FavMealError(AppStrings.errorFetching));
    }
  }
}

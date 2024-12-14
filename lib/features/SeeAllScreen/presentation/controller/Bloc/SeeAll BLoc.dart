import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/features/SeeAllScreen/data/repository/SeeAllRepositoryImpl.dart';

import '../State/SeeAll events.dart';
import '../State/SeeAll state.dart';


class SeeAllBloc extends Bloc<SeeAllEvent, SeeAllStates> {
   SeeAllRepositoryImpl seeAllRepository;

  SeeAllBloc(this.seeAllRepository) : super(SeeAllInitialState()) {
    on<FetchTrendingRecipesEvent>((event, emit) async {
      emit(SeeAllLoadingState());
      try {
    var either=await seeAllRepository.FetchTrendingRecipes();

        await either.fold((l) {
          emit(SeeAllSErrorState(l.error));
        }, (response) async {
emit(SeeAllSuccessState(meals: response));
        });
      } catch (e) {
        emit(SeeAllSErrorState('An unexpected error occurred: ${e.toString()}'));
      }
    });

  }


}

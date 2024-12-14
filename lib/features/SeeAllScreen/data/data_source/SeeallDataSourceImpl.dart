import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import '../../../../core/firebase/firebase_error_model.dart';
import '../../../../core/models/meal.dart';
import '../../../home/data/data_source.dart';


class SeeAllDataSource {
  final firebaseService = GetIt.instance<FirebaseService>();

  Future<Either<FirebaseErrorModel, List<Meal>>> fetchTrendingRecipes() async {
    try {
      List<Meal> meals = await firebaseService.fetchMeals();
      return Right(meals);
    } catch (e) {
      return Left(FirebaseErrorModel(error: e.toString()));
    }
  }
}






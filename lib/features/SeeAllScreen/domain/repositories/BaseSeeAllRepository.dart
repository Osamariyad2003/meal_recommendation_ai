import 'package:dartz/dartz.dart';
import '../../../../core/firebase/firebase_error_model.dart';
import '../../../../core/models/meal.dart';

abstract class BaseSeeAllRepository {
    Future<Either<FirebaseErrorModel,List<Meal>>>  FetchTrendingRecipes();
}
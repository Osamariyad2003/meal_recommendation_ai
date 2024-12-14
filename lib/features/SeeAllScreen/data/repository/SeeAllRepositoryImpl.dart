import 'package:dartz/dartz.dart';


import '../../../../core/firebase/firebase_error_model.dart';
import '../../../../core/models/meal.dart';
import '../../domain/repositories/BaseSeeAllRepository.dart';
import '../data_source/SeeallDataSourceImpl.dart';

class SeeAllRepositoryImpl implements BaseSeeAllRepository {
  SeeAllDataSource seeAllDataSource;
  SeeAllRepositoryImpl({required this.seeAllDataSource});
  @override
  Future<Either<FirebaseErrorModel, List<Meal>>> FetchTrendingRecipes() async {
    final response = await seeAllDataSource.fetchTrendingRecipes();
    return response.fold((error) => Left(error), (response) => Right(response));
  }
}

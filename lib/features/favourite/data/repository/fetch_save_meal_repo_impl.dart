
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';


import '../../../../core/firebase/firebase_error_model.dart';
import '../../../../core/models/meal.dart';
import '../../../../core/utils/strings.dart';
import '../../domain/repositories/fetch_save_fav_repository.dart';

class MealRepositoryImpl_Fetch implements FetchAndSaveFavMealsRepository {
  final FirebaseFirestore fireStore;

  MealRepositoryImpl_Fetch(this.fireStore);

  @override
  Future<List<Meal>> fetchAndSaveFavMeals() async {
    try {
      QuerySnapshot snapshot = await fireStore
          .collection(AppStrings.mealsCollection)
          .where(AppStrings.isFavorite, isEqualTo: true)
          .get();

      final favMeals = snapshot.docs.map((doc) {
        return Meal.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      final box = Hive.isBoxOpen(AppStrings.faveLocalHiveId)
          ? Hive.box<Meal>(AppStrings.faveLocalHiveId)
          : await Hive.openBox<Meal>(AppStrings.faveLocalHiveId);
      for (var meal in favMeals) {
        await box.put(meal.dishName, meal);
      }
      return favMeals;
    } catch (e) {
      throw const FirebaseErrorModel(error: AppStrings.errorFetching);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/features/home/domain/usecase/add_meal_to_fav.dart';
import 'package:meal_recommendation_ai/features/home/domain/usecase/fetch_meals.dart';
import 'package:meal_recommendation_ai/features/home/domain/usecase/remove_meal_from_fireStore.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/di.dart';
import '../../../../core/themes/app_colors.dart';
import '../../domain/usecase/firestore_usecase.dart';
import '../../domain/usecase/remove_meal.dart';
import '../../domain/usecases/meal_usecase.dart';
import '../controller/meal_bloc.dart';
import '../widgets/build_ingredient_button.dart';
import '../widgets/build_search_bar.dart';
import '../widgets/build_top_bar.dart';
import '../widgets/meal_widget.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final padding = EdgeInsets.symmetric(
      vertical: mediaQuery.size.height * 0.02,
      horizontal: mediaQuery.size.width * 0.04,
    );

    // Retrieve the MealUseCase using dependency injection
    final mealUseCase = di<MealUseCase>();

    return SingleChildScrollView(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             BuildTopBar(),
            SizedBox(height: mediaQuery.size.height * 0.02),
             BuildSearchBar(),
            SizedBox(height: mediaQuery.size.height * 0.03),
             BuildIngredientButton(),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildTopRecipesHeader(context),
            SizedBox(height: mediaQuery.size.height * 0.02),
            BlocProvider(
              create: (context) => MealBloc( fetchMealsUseCase: di.get<FetchMeals>(),
                  addMealToFavoritesUseCase: di.get<AddMealToFav>(),
                  removeFavoriteMealUseCase: di.get<RemoveMeal>(),updateIsFavUseCase:di.get<UpdateIsFavInFirestore>(),
                  removeMealFromFirestore: di.get<RemoveMealFromFirestore>() ),
              child:  MealWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRecipesHeader(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Top Recipes',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: mediaQuery.size.width * 0.06,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.seeAll),
          child: Text(
            'See all',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: AppColors.primaryColor,
              fontSize: mediaQuery.size.width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}



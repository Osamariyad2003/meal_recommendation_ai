import 'package:flutter/material.dart';
import 'package:meal_recommendation_ai/features/meal_details/presentation/widgets/summary_tab.dart';

import '../../../../core/models/meal.dart';
import 'direction_tab.dart';
import 'ingredients_tab.dart';


class MealDetailsTabBarView extends StatelessWidget {
  const MealDetailsTabBarView({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        SummaryTab(
          mealSummary: meal.summary!,
        ),
      IngredientsTab(
      ingredients: meal.ingredients ?? [],
    ),
        DirectionTab(steps: meal.mealSteps!),
      ],
    );
  }
}

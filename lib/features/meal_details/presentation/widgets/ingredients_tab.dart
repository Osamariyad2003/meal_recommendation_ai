import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendation_ai/features/meal_details/presentation/widgets/ingredient_item.dart';

import '../../../../core/models/meal.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../../core/utils/strings.dart';


class IngredientsTab extends StatelessWidget {
  const IngredientsTab({super.key, required this.ingredients});

  final List<MealIngredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.totalIngredients}: ${ingredients.length}',
          style: AppTextStyles.font16Regular.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        // SizedBox(height: 8.h),
        SizedBox(
          height: 300.h,
          child: ListView.separated(
            padding: EdgeInsetsDirectional.only(end: 19.w, top: 19.h),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) =>
                IngredientItem(ingredient: ingredients[index]),
            separatorBuilder: (_, __) => const Divider(
              color: AppColors.primaryColor,
            ),
            itemCount: ingredients.length,
          ),
        ),
      ],
    );
  }
}

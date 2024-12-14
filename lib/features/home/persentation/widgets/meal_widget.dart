// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/features/home/persentation/controller/meal_event.dart';
import '../../../../core/helpers/cache_keys.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/models/meal.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../controller/meal_bloc.dart';
import '../controller/meal_state.dart';
import 'build_meal_card.dart';



class MealWidget extends StatefulWidget {
  const MealWidget({super.key});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    final uid = await SecureStorageHelper.getSecuredString(CacheKeys.cachedUserId);
    if (uid != null) {
      setState(() {
        userId = uid;
      });
      context.read<MealBloc>().add(FetchMealsEvent());
    } else {
      debugPrint('No user ID found in secure storage.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return BlocBuilder<MealBloc, MealState>(
      builder: (context, state) {
        if (state is MealLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        } else if (state is MealLoaded) {
          final meals = state.meals;
          if (meals.isEmpty) {
            return Center(
              child: Text(
                'No meals available.',
                style: AppTextStyles.font15MediumBlueGrey,
              ),
            );
          }
          return SingleChildScrollView(
            child: Container(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.01),
                shrinkWrap: true,
                itemCount: meals.length,
                separatorBuilder: (context, index) => SizedBox(height: mediaQuery.size.height * 0.0),
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return BuildMealCard(meal: meal);
                },
              ),
            ),
          );
        } else if (state is MealError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to fetch meals.',
                  style: AppTextStyles.font15MediumBlueGrey,
                ),
                SizedBox(height: mediaQuery.size.height * 0.02),
                ElevatedButton(
                  onPressed: () {
                    if (userId != null) {
                      context.read<MealBloc>().add(FetchMealsEvent());
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text('No meals found.'),
        );
      },
    );
  }
}





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../Widgets/IngredientInputField.dart';
import '../Widgets/meal_details.dart';
import '../bloc/suggested-recipe_event.dart';
import '../bloc/suggested__recipe_bloc.dart';
import '../bloc/suggested_recipe_state.dart';




class MealSuggestionScreen extends StatelessWidget {
  final TextEditingController ingredientController = TextEditingController();

  MealSuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Field with Action
            IngredientInputField(
              controller: ingredientController,
              onGetSuggestionPressed: () {
                final ingredients = ingredientController.text.trim();
                if (ingredients.isNotEmpty) {
                  context.read<SuggestedRecipeBloc>().add(FetchSuggestedRecipeEvent(ingredients));
                }
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // BlocBuilder to handle different states
            BlocBuilder<SuggestedRecipeBloc, SuggestedRecipeState>(
              builder: (context, state) {
                if (state is SuggestedRecipeLoading) {
                  return Center(
                    child: SizedBox(
                      height: screenHeight * 0.05,
                      width: screenHeight * 0.05,
                      child: const CircularProgressIndicator(),
                    ),
                  );
                } else if (state is SuggestedRecipeSuccess) {
                  return Column(
                    children: [
                      RecipeDetails( state: state,),
                      ElevatedButton(onPressed: (){
                        
                        context.read<SuggestedRecipeBloc>().add(SaveSuggestedRecipeEvent(ingredientController.text));
                      }, child: Container(
                        decoration:BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(20)

                        ),
                        child: Text('add to my meals',style: AppTextStyles.font16Regular,),
                      ))
                    ],
                  );
                } else if (state is SuggestedRecipeError) {
                  return ErrorMessage(
                    message: state.errorMessage,
                    textSize: screenWidth * 0.04,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Recipe Suggestion',
        style: AppTextStyles.font18BoldDarkBlue.copyWith(fontWeight: FontWeight.bold),
      ),
      foregroundColor: AppColors.primaryColor,
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final double fontSize;

  const SectionHeader({required this.title, this.fontSize = 20, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryColor,
      ),
    );
  }
}

class ErrorMessage extends StatelessWidget {
  final String message;
  final double textSize;

  const ErrorMessage(
      {required this.message, required this.textSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error: $message',
        style: TextStyle(
          color: Colors.red,
          fontSize: textSize,
        ),
      ),
    );
  }
}

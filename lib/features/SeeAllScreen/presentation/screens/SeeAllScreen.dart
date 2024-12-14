import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/core/routing/routes.dart';
import 'package:meal_recommendation_ai/features/SeeAllScreen/data/repository/SeeAllRepositoryImpl.dart';
import 'package:meal_recommendation_ai/features/sidebar/presentation/screens/side_bar_screen.dart';
import 'package:redacted/redacted.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../domain/repositories/BaseSeeAllRepository.dart';
import '../Widgets/LoadingScreen.dart';
import '../Widgets/Recommended Recipes Item.dart';
import '../Widgets/Trending Recipes Item.dart';
import '../controller/Bloc/SeeAll BLoc.dart';
import '../controller/State/SeeAll events.dart';
import '../controller/State/SeeAll state.dart';

class SeeAllScreen extends StatelessWidget {
  final SeeAllRepositoryImpl seeAllRepository;

   SeeAllScreen({super.key, required this.seeAllRepository});
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SeeAllBloc(seeAllRepository)..add(FetchTrendingRecipesEvent()),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: SideMenu(),
        appBar: AppBar(
          elevation: 0,
          leading:  IconButton(
            onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
              //Navigator.pushNamed(context, Routes.sidebar);
            },
            icon: Icon(
              Icons.menu,
              color: AppColors.primaryColor,
              size: 32,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: AppColors.primaryColor,
                size: 32,
              ),
            ),
          ],
        ),
        body: BlocBuilder<SeeAllBloc, SeeAllStates>(
          builder: (context, state) {
            if (state is SeeAllLoadingState) {
               LoadingSeeAllScreen().redacted(context: context, redact: true);
            } else if (state is SeeAllSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    ' Trending Recipes',
                    style: AppTextStyles.font21BoldDarkBlue,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.24,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.meals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TrendingRecipesItem(
                            meal: state.meals[index],
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    ' Recommended for you',
                    style: AppTextStyles.font21BoldDarkBlue,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.meals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 11),
                            child: RecommendedRecipesItem(
                              meal: state.meals[index],
                            ));
                      },
                    ),
                  ),
                ],
              );
            } else if (state is SeeAllSErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}

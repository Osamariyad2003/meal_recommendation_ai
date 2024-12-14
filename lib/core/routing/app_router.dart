import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_recommendation_ai/core/routing/routes.dart';
import 'package:meal_recommendation_ai/features/GeminiAi/Domain/UseCase/save_suggested_mealUseCase.dart';
import 'package:meal_recommendation_ai/features/sidebar/presentation/screens/side_bar_screen.dart';
import '../../features/GeminiAi/Data/Repo/recipeRepo.dart';
import '../../features/GeminiAi/Data/data_sorce/suggested_meal.dart';
import '../../features/GeminiAi/Domain/UseCase/getRecipeSuggestionUseCase.dart';
import '../../features/GeminiAi/Presentation/Screens/gemini_screen.dart';
import '../../features/GeminiAi/Presentation/bloc/suggested__recipe_bloc.dart';
import '../../features/SeeAllScreen/data/repository/SeeAllRepositoryImpl.dart';
import '../../features/SeeAllScreen/domain/repositories/BaseSeeAllRepository.dart';
import '../../features/SeeAllScreen/presentation/controller/Bloc/SeeAll BLoc.dart';
import '../../features/SeeAllScreen/presentation/controller/State/SeeAll events.dart';
import '../../features/SeeAllScreen/presentation/screens/SeeAllScreen.dart';
import '../../features/auth/Login_Screen/presenation/controller/Login_bloc/bloc/Login BLoc.dart';
import '../../features/auth/Login_Screen/presenation/screens/LoginScreen.dart';
import '../../features/auth/register/persentation/bloc/otp_auth_bloc.dart';
import '../../features/auth/register/persentation/controller/sign_up_bloc.dart';
import '../../features/auth/register/persentation/screens/otp_screen.dart';
import '../../features/auth/register/persentation/screens/register_screen.dart';
import '../../features/favourite/presentation/screens/favourite_screen.dart';
import '../../features/home/domain/usecase/add_meal_to_fav.dart';
import '../../features/home/domain/usecase/fetch_meals.dart';
import '../../features/home/domain/usecase/firestore_usecase.dart';
import '../../features/home/domain/usecase/remove_meal.dart';
import '../../features/home/domain/usecase/remove_meal_from_fireStore.dart';
import '../../features/home/persentation/businessLogic/meal_bloc.dart';
import '../../features/layout/presentation/blocs/layout_bloc.dart';
import '../../features/layout/presentation/views/layout_view.dart';
import '../../features/meal_details/presentation/views/meal_details_view.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/sidebar/presentation/controller/bloc/side_bloc.dart';
import '../../features/splash_boarding/screens/on_boarding_screen.dart';
import '../../features/splash_boarding/screens/splash_screen.dart';
import '../models/meal.dart';
import '../services/di.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case Routes.sidebar:
              return MaterialPageRoute(
          builder: (_) =>      BlocProvider(create: (context) => SideBarBloc(di()),child: SideMenu(),),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => di<UserBloc>(), child: RegisterScreen()),
        );

      case Routes.login:
        return _loginRoute();

      case Routes.verifyOtp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<OtpAuthBloc>(
                create: (_) => OtpAuthBloc(), child: const OtpScreen()));

      // case Routes.home:
      //   return MaterialPageRoute(
      //       builder: (_) => BlocProvider(
      //             create: (context) => MealCubit(
      //                 fetchMealsUseCase: FetchMeals(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 addMealToFavoritesUseCase: AddMealToFav(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 removeFavoriteMealUseCase: RemoveMeal(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 updateIsFavUseCase: UpdateIsFavInFirestore(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 removeMealFromFirestore: RemoveMealFromFirestore(
      //                     MealRepositoryImpl(FirebaseService(), LocalData())),
      //                 localData: LocalData())
      //               ..fetchMeals(),
      //             child: const HomeScreen(),
      //           ));

      case Routes.favourite:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );

      case Routes.layout:
        return _layoutRoute();

      case Routes.mealDetails:
        final args = settings.arguments as Meal;
        return MaterialPageRoute(
          builder: (_) => MealDetailsView(meal: args),
        );
      case Routes.seeAll:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
             BlocProvider(
                  create: (context) => SeeAllBloc(di<SeeAllRepositoryImpl>())
                 ..add(FetchTrendingRecipesEvent())),
              BlocProvider(create: (context) => SideBarBloc(di())),

            ],

              child: SeeAllScreen(seeAllRepository: di<SeeAllRepositoryImpl>()),
            ),
        );

      case Routes.mealSuggestion:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SuggestedRecipeBloc>(
                create: (_) => SuggestedRecipeBloc(GetRecipeSuggestionUseCase(
                    RecipeRepository(RecipeRemoteDatasource())),SaveRecipeSuggestionUseCase(
                    RecipeRepository(RecipeRemoteDatasource()))),
                child: MealSuggestionScreen()));
      default:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
    }
  }

  static MaterialPageRoute<dynamic> _loginRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return BlocProvider(
          create: (_) => di<LoginBloc>(),
          child: const LoginScreen(),
        );
      },
    );
  }

  static MaterialPageRoute<dynamic> _layoutRoute() {
    return MaterialPageRoute(
        builder: (_) => MultiBlocProvider(providers: [
              BlocProvider(create: (context) => SideBarBloc(di())),
              BlocProvider<LayoutBloc>(
                create: (_) => di.get<LayoutBloc>(),
              ),
          BlocProvider(
            create: (context) => MealBloc(
              fetchMealsUseCase: FetchMeals(di()),
              addMealToFavoritesUseCase: AddMealToFav(di()),
              removeFavoriteMealUseCase: RemoveMeal(di()),
              updateIsFavUseCase: UpdateIsFavInFirestore(di()),
              removeMealFromFirestore: RemoveMealFromFirestore(di()),
            ),
          ),

        ], child:  LayoutView()));
  }
}

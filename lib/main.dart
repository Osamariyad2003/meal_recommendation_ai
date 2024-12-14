import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/models/meal.dart';
import 'core/models/meal_adapter.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/services/di.dart';
import 'core/themes/app_themes.dart';
import 'core/utils/functions/check_if_user_is_logged_in.dart';
import 'core/utils/strings.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding:  WidgetsFlutterBinding.ensureInitialized());
  setupServiceLocator();
  await Hive.initFlutter();
  await Hive.openBox('appBox');
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(MealSummaryAdapter());
  Hive.registerAdapter(MealNutritionAdapter());
  Hive.registerAdapter(MealIngredientAdapter());
  await Hive.openBox<Meal>('myFavMeals');
  await checkIfUserIsLoggedIn();
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            onGenerateRoute: AppRouter.onGenerateRoute,
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            initialRoute: Routes.splash,
          );
        });

  }
}


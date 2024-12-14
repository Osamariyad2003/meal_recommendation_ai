import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/strings.dart';
import 'app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightTheme => ThemeData(
        colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        fontFamily: AppStrings.fontFamily,
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundLightColor,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.scaffoldBackgroundLightColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.scaffoldBackgroundLightColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
      );
}

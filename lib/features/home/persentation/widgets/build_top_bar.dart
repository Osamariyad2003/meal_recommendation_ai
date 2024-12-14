import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_recommendation_ai/features/sidebar/presentation/screens/side_bar_screen.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../core/routing/routes.dart';

class BuildTopBar extends StatelessWidget {
   BuildTopBar({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.073,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, Routes.mealSuggestion);
          },
          icon: Icon(
            FontAwesomeIcons.robot,
            color: AppColors.primaryColor,
            size: MediaQuery.of(context).size.width * 0.073,
          ),
        ),
      ],
    );
  }
}

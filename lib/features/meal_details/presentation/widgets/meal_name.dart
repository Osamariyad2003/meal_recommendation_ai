import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/app_text_styles.dart';

class MealName extends StatelessWidget {
  const MealName({
    super.key,
    required this.mealName,
  });

  final String mealName;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 11.h),
      child: Text(
        mealName,
        style: AppTextStyles.font28BoldDarkBlue,
        maxLines: 3,
      ),
    );
  }
}

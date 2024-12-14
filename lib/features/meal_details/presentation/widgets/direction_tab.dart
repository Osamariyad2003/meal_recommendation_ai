import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_recommendation_ai/features/meal_details/presentation/widgets/step_item.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/my_sized_box.dart';


class DirectionTab extends StatelessWidget {
  const DirectionTab({super.key, required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.totalSteps}: ${steps.length}',
          style: AppTextStyles.font16Regular.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        Expanded(
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.only(end: 19.w, top: 19.h),
            itemBuilder: (_, index) => StepItem(
              stepNumber: index + 1,
              step: steps[index],
            ),
            separatorBuilder: (_, __) => MySizedBox.height17,
            itemCount: steps.length,
          ),
        ),
      ],
    );
  }
}

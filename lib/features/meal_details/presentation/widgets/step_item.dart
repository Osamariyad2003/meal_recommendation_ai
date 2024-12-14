import 'package:flutter/material.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/themes/app_text_styles.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/my_sized_box.dart';


class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.step,
    required this.stepNumber,
  });

  final String step;
  final int stepNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppStrings.step} $stepNumber',
          style: AppTextStyles.font20Bold.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        MySizedBox.height8,
        Text(
          step,
          style: AppTextStyles.font16Regular.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

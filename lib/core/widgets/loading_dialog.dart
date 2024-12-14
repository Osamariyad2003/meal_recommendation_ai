import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../utils/strings.dart';
import 'my_sized_box.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LoadingIndicator(
            indicatorType: Indicator.ballRotateChase,
            colors: [AppColors.primaryColor],
          ),
          MySizedBox.height19,
          Text(
            AppStrings.pleaseWait,
            style: AppTextStyles.font18RegularDarkBlue,
          ),
        ],
      ),
    );
  }
}

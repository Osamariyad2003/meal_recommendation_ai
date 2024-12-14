import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSizedBox extends StatelessWidget {
  final double? height, width;

  const CustomSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
    );
  }
}

class MySizedBox {
  MySizedBox._();

  static const CustomSizedBox height19 = CustomSizedBox(height: 19);
  static const CustomSizedBox height11 = CustomSizedBox(height: 11);
  static const CustomSizedBox height8 = CustomSizedBox(height: 8);
  static const CustomSizedBox height17 = CustomSizedBox(height: 17);
}

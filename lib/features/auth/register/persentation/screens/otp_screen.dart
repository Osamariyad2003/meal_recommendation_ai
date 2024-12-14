import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/themes/app_text_styles.dart';
import '../bloc/otp_auth_bloc.dart';
import '../bloc/otp_auth_event.dart';
import '../bloc/otp_auth_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final String phoneNumber = "+2001015466730";
  String otpCode = "";
  bool isButtonEnabled = false;

  void _onOtpChange(String value) {
    setState(() {
      otpCode = value;
      isButtonEnabled = otpCode.length == 4;
    });
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth_background.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          decoration:
          BoxDecoration(color: AppColors.primaryColor.withOpacity(0.85)),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 80.h),
        Image.asset(
          'assets/images/logo.png',
          width: 135.w,
          height: 135.h,
        ),
        SizedBox(height: 20.h),
        Text(
          'Verification',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'Enter 4 digits verification code. We just sent you on $phoneNumber',
          textAlign: TextAlign.center,
          style: AppTextStyles.font18RegularDarkBlue.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField() {
    return OtpTextField(
      onSubmit: (value) => _onOtpChange(value),
      onCodeChanged: (_) => setState(() => isButtonEnabled = false),
      focusedBorderColor: Colors.white,
      showFieldAsBox: true,
      fillColor: Colors.white,
      fieldWidth: 60.w,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      filled: true,
    );
  }

  Widget _buildContinueButton() {
    return BlocBuilder<OtpAuthBloc, OtpAuthState>(
      builder: (context, state) {
        if (state is OtpAuthLoading) {
          _showMyDialog(context);
        } else if (state is OtpAuthSuccess) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is OtpAuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }

        return GestureDetector(
          onTap: isButtonEnabled
              ? () {
            // Trigger the OTP verification event
            context.read<OtpAuthBloc>().add(
              VerifyOtpEvent(
                verificationId: '', // TODO: Add actual verificationId
                otpCode: otpCode,
              ),
            );
            _showMyDialog(context);
          }
              : null,
          child: Container(
            width: 324.w,
            height: 57.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45.r),
            ),
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 30.h),
                _buildOtpField(),
                SizedBox(height: 30.h),
                _buildContinueButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showMyDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 80,
              child: Transform.scale(
                scale: 0.7,
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [AppColors.primaryColor],
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Please wait...',
              style: AppTextStyles.font18RegularDarkBlue,
            ),
          ],
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/auth/provider/phone_provider.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_provider.dart';
import 'package:fork_up/presentation/auth/screens/verification_screen.dart';
import 'package:fork_up/presentation/auth/widgets/custom_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignWithPhoneScreen extends ConsumerStatefulWidget {
  const SignWithPhoneScreen({super.key});

  @override
  ConsumerState<SignWithPhoneScreen> createState() =>
      _SignWithPhoneScreenState();
}

class _SignWithPhoneScreenState extends ConsumerState<SignWithPhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String fullPhone = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final state = ref.watch(sendOtpProvider);
    ref.listen(sendOtpProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data == null) return;
          ref.read(phoneProvider.notifier).state = fullPhone;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VerificationScreen(phone: fullPhone, otp: data.otp),
            ),
          );
        },

        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            top: 20,
            right: 24,
            left: 24,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'skip',
                    style: TextStyle(
                      color: AppColors.lightGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'Login or Sign Up',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "we'll send you an SMS with a verification code.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGray,
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Phone Number',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                IntlPhoneField(
                  validator: (value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Phone number is required';
                    }

                    if (value.number.length < 10) {
                      return 'Invalid phone number';
                    }

                    return null;
                  },
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Phone',
                    hintStyle: TextStyle(
                      color: AppColors.lightGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGray),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightGray,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.lightGray),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightGray,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  initialCountryCode: 'EG',
                  showCountryFlag: false,
                  disableLengthCheck: true,
                  onChanged: (phone) {
                    fullPhone = phone.completeNumber.replaceAll('+', '');
                  },
                ),
                SizedBox(height: 40),
                Center(
                  child: state.isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ref
                                  .read(sendOtpProvider.notifier)
                                  .sendOtp(phone: fullPhone);
                            }
                          },
                          text: "Next",
                          horizontal: 130,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

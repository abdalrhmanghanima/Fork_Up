import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/auth/provider/chek_login/check_login_provider.dart';
import 'package:fork_up/presentation/auth/provider/fcm_use_case_provider.dart';
import 'package:fork_up/presentation/auth/provider/local_data_source_provider.dart';
import 'package:fork_up/presentation/auth/provider/send_otp/send_otp_provider.dart';
import 'package:fork_up/presentation/auth/provider/verify/verify_provider.dart';
import 'package:fork_up/presentation/auth/screens/sign_up_screen.dart';
import 'package:fork_up/presentation/auth/widgets/custom_button.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_provider.dart';
import 'package:fork_up/presentation/root.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  final String phone;
  final String otp;
  const VerificationScreen({super.key, required this.phone, required this.otp});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  TextEditingController otpController = TextEditingController();
  int seconds = 300;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');

    final secs = (seconds % 60).toString().padLeft(2, '0');

    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final verifyState = ref.watch(verifyProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
        title: const Text("OTP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 20, right: 24, left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Verify your mobile\nnumber',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Enter the verification code we send you to:\n ${widget.phone}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.lightGray,
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Pinput(
                defaultPinTheme: PinTheme(
                  width: 75,
                  height: 72,
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: BoxBorder.all(color: AppColors.lightGray),
                  ),
                ),
                length: 4,
                controller: otpController,
                keyboardType: TextInputType.number,
                autofocus: true,
                separatorBuilder: (index) => const SizedBox(width: 12),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn’t receive code? ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGray,
                  ),
                ),
                GestureDetector(
                  onTap: seconds == 0
                      ? () {
                          ref
                              .read(sendOtpProvider.notifier)
                              .sendOtp(phone: widget.phone);
                          setState(() {
                            seconds = 300;
                          });
                          startTimer();
                        }
                      : null,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      color: seconds == 0 ? AppColors.yellow : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppIcons.time),
                SizedBox(width: 8),
                Text(formatTime(seconds)),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: verifyState.isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () async {
                        if (otpController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Enter OTP')),
                          );
                          return;
                        }
                        if (otpController.text == widget.otp) {
                          final otpData = ref.read(sendOtpProvider).value;

                          final isRegistered =
                              otpData?.user?.isRegistered ?? false;

                          if (isRegistered) {
                            final token = otpData?.user?.token;

                            if (token != null && token.isNotEmpty) {
                              await ref
                                  .read(authLocalDataSourceProvider)
                                  .saveToken(token);

                              await ref
                                  .read(checkLoginProvider.notifier)
                                  .checkLogin();
                              ref.invalidate(getProfileProvider);
                            }

                            await ref.read(storeFcmUseCaseProvider).call();

                            if (!context.mounted) return;

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => Root()),
                              (route) => false,
                            );
                          } else {
                            if (!context.mounted) return;

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Wrong OTP')),
                          );
                        }
                      },
                      text: "Verify",
                      horizontal: 130,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

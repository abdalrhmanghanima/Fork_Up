import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/presentation/auth/provider/chek_login/check_login_provider.dart';
import 'package:fork_up/presentation/auth/provider/create_account/create_account_provider.dart';
import 'package:fork_up/presentation/auth/provider/local_data_source_provider.dart';
import 'package:fork_up/presentation/auth/provider/phone_provider.dart';
import 'package:fork_up/presentation/auth/widgets/custom_button.dart';
import 'package:fork_up/presentation/auth/widgets/custom_text_field.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_provider.dart';
import 'package:fork_up/presentation/root.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isAgreed = false;

  void toggleAgree() {
    setState(() {
      isAgreed = !isAgreed;
    });
  }

  @override
  void initState() {
    super.initState();

    ref.listenManual(createAccountProvider, (previous, next) {
      next.whenOrNull(
        data: (data) async {
          if (data == null) return;

          if (data.user.token != null) {
            await ref
                .read(authLocalDataSourceProvider)
                .saveToken(data.user.token!);

            await ref
                .read(checkLoginProvider.notifier)
                .checkLogin();

            ref.invalidate(getProfileProvider);
          }

          if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Root(),
            ),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
            ),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final phone = ref.watch(phoneProvider);

    final state = ref.watch(createAccountProvider);

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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your new\naccount',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Create an account to start looking for\nthe food you like',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGray,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          isPassword: false,
                          controller: fNameController,
                          label: 'First Name',
                          hintText: 'FName',
                          horizontal: 8,
                          vertical: 20,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "First name is required";
                            }

                            if (value.trim().length < 2) {
                              return "Enter valid first name";
                            }

                            return null;
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: CustomTextField(
                          isPassword: false,
                          controller: lNameController,
                          label: 'Last Name',
                          hintText: 'LName',
                          horizontal: 8,
                          vertical: 20,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Last name is required";
                            }

                            if (value.trim().length < 2) {
                              return "Enter valid last name";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  CustomTextField(
                    controller: emailController,
                    label: "Email Address",
                    hintText: "Enter Your Email",
                    isPassword: false,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return "Enter valid email";
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      GestureDetector(
                        onTap: toggleAgree,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color:
                            isAgreed
                                ? AppColors.yellow
                                : Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:
                          isAgreed
                              ? Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SvgPicture.asset(
                              AppIcons.checkWhite,
                              fit: BoxFit.fitWidth,
                            ),
                          )
                              : null,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'I Agree with ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.yellow,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 45),

                  Center(
                    child:
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                      horizontal: 100,
                      text: "Create Account",
                      onPressed: () {
                        if (!isAgreed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Please agree to Privacy Policy",
                              ),
                            ),
                          );

                          return;
                        }

                        if (formKey.currentState!.validate()) {
                          ref
                              .read(
                            createAccountProvider.notifier,
                          )
                              .createAccount(
                            phone: phone,
                            firstName: fNameController.text.trim(),
                            lastName: lNameController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
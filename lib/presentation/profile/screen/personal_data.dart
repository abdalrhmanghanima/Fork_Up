import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/core/utils/app_images.dart';
import 'package:fork_up/presentation/auth/widgets/custom_button.dart';
import 'package:fork_up/presentation/auth/widgets/custom_text_field.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_provider.dart';
import 'package:fork_up/presentation/profile/provider/pick_image_provider.dart';
import 'package:fork_up/presentation/profile/provider/update_profile_provider.dart';
import 'package:fork_up/presentation/profile/widgets/personal_data_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class PersonalData extends ConsumerStatefulWidget {
  const PersonalData({super.key});

  @override
  ConsumerState<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends ConsumerState<PersonalData> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final image = ref.watch(pickImageProvider);
    final userState = ref.watch(getProfileProvider);
    final updateState = ref.watch(updateProfileProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
        title: const Text("Personal Data"),
        centerTitle: true,
      ),
      body: userState.when(
        data: (data) {
          final imageUrl =
              "https://maxim.envirogroup.io/storage/app/public/${data.image}";
          nameController.text = "${data.firstName} ${data.lastName}";
          emailController.text = data.email ?? "no mail";
          phoneController.text = data.phone ?? "";
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          child: ClipOval(
                            child: image != null
                                ? Image.file(
                                    image,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,

                                    errorWidget: (context, url, error) {
                                      return Image.asset(
                                        AppImages.user,
                                        fit: BoxFit.cover,
                                      );
                                    },

                                    placeholder: (context, url) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            child: IconButton(
                              onPressed: () {
                                ref
                                    .read(pickImageProvider.notifier)
                                    .pickImage();
                              },
                              icon: SvgPicture.asset(AppIcons.camera),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTextField(
                  controller: nameController,
                  label: "Full Name",
                  isPassword: false,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: phoneController,
                  label: "Phone",
                  isPassword: false,
                ),
                SizedBox(height: 8),
                CustomTextField(
                  controller: emailController,
                  label: "Email",
                  isPassword: false,
                ),
                SizedBox(height: 55),
                updateState.isLoading? const CircularProgressIndicator():
                CustomButton(
                  text: "Save",
                  onPressed: () async {
                    final fullName = nameController.text.trim();

                    final nameParts = fullName.split(" ");

                    final firstName = nameParts.first;

                    final lastName = nameParts.length > 1
                        ? nameParts.sublist(1).join(" ")
                        : "";
                    await ref
                        .read(updateProfileProvider.notifier)
                        .updateProfile(
                          firstName: firstName,
                          lastName: lastName,
                          image: image,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                    ref.invalidate(getProfileProvider);

                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        },
        loading: () {
          return const PersonalDataShimmer();
        },

        error: (error, stack) {
          return Center(child: Text(error.toString()));
        },
      ),
    );
  }
}

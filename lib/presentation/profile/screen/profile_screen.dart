import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/core/utils/app_images.dart';
import 'package:fork_up/presentation/auth/provider/chek_login/check_login_provider.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_provider.dart';
import 'package:fork_up/presentation/profile/provider/pick_image_provider.dart';
import 'package:fork_up/presentation/profile/screen/personal_data.dart';
import 'package:fork_up/presentation/profile/widgets/custom_row.dart';
import 'package:fork_up/presentation/profile/widgets/profile_shimmer_widget.dart';
import 'package:fork_up/presentation/wish_list/screen/wish_list_screen.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final userState = ref.watch(getProfileProvider);
    final image = ref.watch(pickImageProvider);
    final isLogged = ref.watch(checkLoginProvider);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.04),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(AppIcons.back),
          ),
        ),
        title: const Text("Profile Settings"),
        centerTitle: true,
      ),
      body: userState.when(
        data: (data) {
          final imageUrl =
              "https://maxim.envirogroup.io/storage/app/public/${data.image}";
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
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
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "${data.firstName} ${data.lastName}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGray,
                  ),
                ),
                CustomRow(
                  onTap: () {
                    isLogged
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WishListScreen(),
                            ),
                          )
                        : SizedBox.shrink();
                  },
                  name: "Wish List",
                  prefixIcon: AppIcons.wishList,
                ),
                CustomRow(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonalData()),
                    );
                  },
                  name: "Personal Data",
                  prefixIcon: AppIcons.profile,
                ),
                CustomRow(
                  onTap: () {},
                  name: "Orders",
                  prefixIcon: AppIcons.orders,
                ),
                CustomRow(
                  onTap: () {},
                  name: "Address",
                  prefixIcon: AppIcons.address,
                ),
                Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightGray,
                  ),
                ),
                CustomRow(
                  onTap: () {},
                  name: "Contact Us",
                  prefixIcon: AppIcons.callUs,
                ),
                CustomRow(
                  onTap: () {},
                  name: "Language",
                  prefixIcon: AppIcons.language,
                ),
                CustomRow(
                  onTap: () {},
                  name: "Request Account Deletion",
                  prefixIcon: AppIcons.deleteWhite,
                ),
              ],
            ),
          );
        },
        loading: () {
          return const ProfileShimmerWidget();
        },

        error: (error, stack) {
          return Center(child: Text(error.toString()));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/presentation/profile/provider/get_profile_provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileHeader extends ConsumerWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(getProfileProvider);

    return profileState.when(
      data: (data) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              "${data.firstName} ${data.lastName}",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        );
      },
      loading: () {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade200,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 14,
                width: 70,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                height: 16,
                width: 140,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stack) {
        return Text(error.toString());
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerWidget extends StatelessWidget {
  const ProfileShimmerWidget({super.key});

  Widget shimmerBox({
    required double height,
    required double width,
    double radius = 12,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget rowShimmer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          shimmerBox(height: 45, width: 45, radius: 14),

          const SizedBox(width: 14),

          shimmerBox(height: 16, width: 140),

          const Spacer(),

          shimmerBox(height: 18, width: 18, radius: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Center(child: shimmerBox(height: 18, width: 150)),

            const SizedBox(height: 35),

            shimmerBox(height: 14, width: 70),

            const SizedBox(height: 20),

            rowShimmer(),
            rowShimmer(),
            rowShimmer(),
            rowShimmer(),

            const SizedBox(height: 20),

            shimmerBox(height: 14, width: 70),

            const SizedBox(height: 20),

            rowShimmer(),
            rowShimmer(),
            rowShimmer(),
          ],
        ),
      ),
    );
  }
}

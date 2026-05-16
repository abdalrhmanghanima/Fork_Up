import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PersonalDataShimmer extends StatelessWidget {
  const PersonalDataShimmer({super.key});

  Widget shimmerBox({
    required double height,
    required double width,
    double radius = 14,
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

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            shimmerBox(height: 58, width: double.infinity),

            const SizedBox(height: 12),

            shimmerBox(height: 58, width: double.infinity),

            const SizedBox(height: 12),

            shimmerBox(height: 58, width: double.infinity),

            const SizedBox(height: 60),

            shimmerBox(height: 55, width: double.infinity, radius: 40),
          ],
        ),
      ),
    );
  }
}

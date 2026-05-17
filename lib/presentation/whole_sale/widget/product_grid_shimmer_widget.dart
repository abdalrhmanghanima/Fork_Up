import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridShimmerWidget extends StatelessWidget {
  const ProductGridShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: width * 0.28,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),

                  child: Container(
                    height: 14,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),

                  child: Container(
                    height: 14,
                    width: width * 0.2,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const Spacer(),

                Align(
                  alignment: Alignment.bottomRight,

                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                      bottom: 8,
                    ),

                    child: Container(
                      height: 34,
                      width: 34,

                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailsShimmer extends StatelessWidget {
  const ProductDetailsShimmer({super.key});

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width * 0.04),

            shimmerBox(height: width * 0.8, width: double.infinity, radius: 20),

            SizedBox(height: width * 0.05),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(height: 18, width: width * 0.5),

                      SizedBox(height: 12),

                      shimmerBox(height: 16, width: width * 0.25),
                    ],
                  ),
                ),

                shimmerBox(height: 16, width: width * 0.15),
              ],
            ),

            SizedBox(height: width * 0.05),

            shimmerBox(height: 55, width: double.infinity),

            SizedBox(height: width * 0.06),

            shimmerBox(height: 18, width: width * 0.3),

            SizedBox(height: width * 0.03),

            Column(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: shimmerBox(height: 12, width: double.infinity),
                ),
              ),
            ),

            SizedBox(height: width * 0.06),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerBox(height: 18, width: width * 0.35),

                shimmerBox(height: 18, width: width * 0.15),
              ],
            ),

            SizedBox(height: width * 0.05),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      shimmerBox(height: 120, width: double.infinity),

                      SizedBox(height: 15),

                      shimmerBox(height: 25, width: 25, radius: 30),

                      SizedBox(height: 15),

                      shimmerBox(height: 120, width: double.infinity),
                    ],
                  ),
                ),

                SizedBox(width: 16),

                Expanded(
                  child: shimmerBox(height: 300, width: double.infinity),
                ),
              ],
            ),

            SizedBox(height: width * 0.07),
            shimmerBox(height: 18, width: width * 0.4),

            SizedBox(height: width * 0.05),

            SizedBox(
              height: 240,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(height: 160, width: 150),

                      SizedBox(height: 10),

                      shimmerBox(height: 14, width: 100),

                      SizedBox(height: 8),

                      shimmerBox(height: 14, width: 70),
                    ],
                  );
                },
                separatorBuilder: (_, __) => SizedBox(width: 12),
                itemCount: 4,
              ),
            ),

            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}

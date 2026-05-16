import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

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
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerBox(height: 230, width: double.infinity, radius: 0),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: shimmerBox(height: 20, width: 180),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 250,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerBox(height: 170, width: 150),
                      const SizedBox(height: 10),
                      shimmerBox(height: 15, width: 120),
                      const SizedBox(height: 8),
                      shimmerBox(height: 15, width: 80),
                    ],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: 4,
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: shimmerBox(height: 20, width: 120),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 170,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, __) => Column(
                    children: [
                      shimmerBox(height: 120, width: 140),
                      const SizedBox(height: 10),
                      shimmerBox(height: 15, width: 90),
                    ],
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemCount: 5,
                ),
              ),

              const SizedBox(height: 25),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: shimmerBox(height: 40, width: 120, radius: 20),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: shimmerBox(height: 150, width: double.infinity),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/utils/app_colors.dart';
import 'package:fork_up/presentation/home/providers/home_provider.dart';

class OffersWidget extends ConsumerWidget{
  final Axis scrollDirection;
  final double? height;
  final  EdgeInsetsGeometry? margin;
  const OffersWidget({super.key, required this.scrollDirection, this.height, this.margin});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
          return homeState.when(
              data: (data) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    height: height,
                    child: ListView.builder(
                      scrollDirection: scrollDirection,
                      itemCount: data.data.offers.length,
                      itemBuilder: (context, index) {
                        final offer = data.data.offers[index];
                        return Container(
                          margin: margin,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox(
                                      height: 140,
                                      width: 350,
                                      child: CachedNetworkImage(
                                        imageUrl: offer.url,
                                        fit: BoxFit.cover,

                                        fadeInDuration: Duration.zero,
                                        fadeOutDuration: Duration.zero,

                                        placeholder: (context, url) =>
                                            Container(
                                              color: Colors.grey.shade200,
                                            ),

                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.image_not_supported),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 140,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(
                                            alpha: 0.7,
                                            red: 0.6,
                                            green: 0.6,
                                            blue: 0.6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    top: 20,
                                    child: Container(
                                      width: 88,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16,
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 3,
                                        ),
                                        child: Text(
                                          "limited time",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.darkGray,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 16,
                                    bottom: 17,
                                    child: Container(
                                      width: 70,
                                      height: 26,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16,
                                        ),
                                        color: Colors.yellow,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 3,
                                        ),
                                        child: Text(
                                          "order",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 16,
                                    bottom: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "get special offer",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "up to 60% off",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },

            error: (error, stack) {
              return Center(
                child: Text(error.toString()),
              );
            },
          );
        }
  }

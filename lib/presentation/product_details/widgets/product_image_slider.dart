import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/product_details/entity/mapper/product_details_mapper.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/presentation/wish_list/provider/wish_list_provider.dart';

class ProductImagesSlider extends ConsumerStatefulWidget {
  final ProductDetailsEntity product;
  final List<String> images;

  const ProductImagesSlider({
    super.key,
    required this.images,
    required this.product,
  });

  @override
  ConsumerState<ProductImagesSlider> createState() =>
      _ProductImagesSliderState();
}

class _ProductImagesSliderState
    extends ConsumerState<ProductImagesSlider> {
  int currentIndex = 0;

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final wishListState = ref.watch(wishlistProvider);

    final isExist = wishListState.any(
          (e) => e.id == widget.product.id,
    );

    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: 360,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),

        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
               ref
                  .read(wishlistProvider.notifier)
                  .toggle(widget.product.toProduct());

              if (!context.mounted) return;

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isExist
                        ? 'Removed from wishlist'
                        : 'Added to wishlist',
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: isExist
                  ? SvgPicture.asset(AppIcons.likeFilled)
                  : SvgPicture.asset(AppIcons.like),
            ),
          ),
        ),

        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: currentIndex == index ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? Colors.orange
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
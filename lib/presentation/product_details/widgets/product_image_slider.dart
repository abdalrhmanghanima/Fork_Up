import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fork_up/core/utils/app_icons.dart';
import 'package:fork_up/domain/product_details/entity/mapper/product_details_mapper.dart';
import 'package:fork_up/domain/product_details/entity/product_details_entity.dart';
import 'package:fork_up/presentation/wish_list/cubit/wish_list_cubit.dart';

class ProductImagesSlider extends StatefulWidget {
  final ProductDetailsEntity product;

  final List<String> images;

  const ProductImagesSlider({super.key, required this.images,required this.product});

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {

  int currentIndex = 0;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
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
              final isExist = context
                  .read<WishlistCubit>()
                  .isInWishlist(widget.product.toProduct());
              context.read<WishlistCubit>().toggle(
                widget.product.toProduct(),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isExist
                          ? 'Removed from wishlist'
                          : 'Added to wishlist',
                    ),
                    duration: Duration(seconds: 1),
                  )
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: context.watch<WishlistCubit>().isInWishlist(widget.product.toProduct())
                  ? SvgPicture.asset(AppIcons.likeFilled)
                  : SvgPicture.asset(AppIcons.like)),
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
                margin: EdgeInsets.symmetric(horizontal: 3),
                width: currentIndex == index ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.orange : Colors.grey,
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

import 'package:flutter/material.dart';
import 'package:fork_up/presentation/home/widgets/product_card_widget.dart';
import 'package:fork_up/presentation/product_details/screen/product_details_screen.dart';

class ProductHorizontalList extends StatelessWidget {
  final List<dynamic> products;

  const ProductHorizontalList({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductCard(
              image: product.thumbnail,
              name: product.name,
              price: product.priceBeforeDiscount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ProductDetailsScreen(product: product),
                  ),
                );
              },
              onAdd: () {
                // add to cart logic
              },
              onLike: () {
                // like logic
              },
            );
          },
        ),
      ),
    );
  }
}
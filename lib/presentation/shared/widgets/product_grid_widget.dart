import 'package:flutter/material.dart';
import 'package:fork_up/presentation/home/widgets/product_card_widget.dart';

class ProductGridWidget<T> extends StatelessWidget {
  final List<T> items;

  final String Function(T item) image;
  final String Function(T item) name;
  final double Function(T item) price;
  final void Function(T item)? onTap;
  final void Function(T item)? onAdd;
  final void Function(T item)? onLike;
  final ScrollController? controller;
  final Widget Function(T item) favourite;
  final Widget Function(T item) add;

  const ProductGridWidget({
    super.key,
    required this.items,
    required this.image,
    required this.name,
    required this.price,
    this.onTap,
    this.onAdd,
    this.controller,
    required this.favourite,
    this.onLike,
    required this.add,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return ProductCard(
          favourite: favourite.call(item),
          image: image(item),
          name: name(item),
          price: price(item),
          add: add.call(item),
          onLike: () => onLike?.call(item),
          onAdd: () => onAdd?.call(item),
          onTap: () => onTap?.call(item),
        );
      },
    );
  }
}

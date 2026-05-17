import 'package:dio/dio.dart';
import 'package:fork_up/core/constants/api_const.dart';
import 'package:fork_up/data/cart/data_source/cart_remote_data_source.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRemoteDataSourceImpl
    implements CartRemoteDataSource {

  final Dio dio;

  CartRemoteDataSourceImpl(this.dio);

  @override
  Future<void> addToCart({
    required int productId,
    required int quantity,
    int? variantId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final formData = FormData.fromMap({
      'product_id': productId,
      'quantity': quantity,
      if (variantId != null)
        'variant_id': variantId,
    });

    print('Sending add to cart...');
    print(formData.fields);

    final response = await dio.post(
      ApiConstants.addToCart,
      data: formData,
        options: Options(
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language":"en"
          },
        )
    );

    print('Status code: ${response.statusCode}');
    print('Response: ${response.data}');
  }
  @override
  Future<List<CartEntity>> getCart() async {

    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await dio.get(
      ApiConstants.getCart,
      options: Options(
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": "en",
        },
      ),
    );

    final List items = response.data['data'];
    print(items);

    return items.map((e) {

      final product = e;

      return CartEntity(
        product: ProductEntity(
          id: product['id'],
          name: product['name'],
          categoryIds:
          List<int>.from(product['category_ids'] ?? []),

          priceBeforeDiscount:
          (product['price_before_discount'] ?? 0)
              .toDouble(),

          priceAfterDiscount:
          (product['price_after_discount'] ?? 0)
              .toDouble(),

          thumbnail: product['thumbnail'] ?? '',

          images:
          List<String>.from(product['images'] ?? []),

          inWishlist: product['in_wishlist'] ?? false,

          slug: product['slug'] ?? '',

          productStockCount:
          product['product_stock_count'] ?? 0,

          discount:
          (product['discount'] ?? 0).toDouble(),

          isTaxable:
          product['is_taxable'] ?? false,

          variants: [],
        ),

        quantity: product['cart_count'] ?? 1,
      );

    }).toList();
  }
}
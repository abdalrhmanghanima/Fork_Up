import 'package:fork_up/data/cart/data_source/cart_local_data_source.dart';
import 'package:fork_up/data/cart/data_source/cart_remote_data_source.dart';
import 'package:fork_up/data/cart/model/cart_model.dart';
import 'package:fork_up/domain/cart/entity/cart_entity.dart';
import 'package:fork_up/domain/cart/repository/cart_repo.dart';
import 'package:fork_up/domain/home/entity/product_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CartRemoteDataSource remoteDataSource;
  CartRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<List<CartEntity>> getCart() async {
    final cartModels=await localDataSource.getCart();
    return cartModels.map((e)=> e.toEntity()).toList();
  }

  @override
  Future<void> addToCart(ProductEntity product, {int quantity = 1}) async {
    final cartItems = await localDataSource.getCart();
    final index = cartItems.indexWhere((e) => e.product.id == product.id);

    if (index != -1) {
      final updateItem =
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + quantity,
      );
      await localDataSource.addToCart(updateItem);
    } else {
      final cartEntity = CartEntity(
        product: product,
        quantity: quantity,
      );

      final cartModel = CartModel.fromEntity(cartEntity);
      await localDataSource.addToCart(cartModel);
      try {
        await remoteDataSource.addToCart(
          productId: product.id,
          quantity: quantity,
        );
      } catch (e) {
        print(e);
      }

    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await localDataSource.removeFromCart(productId);
  }

  @override
  Future<void> clear() async {
    localDataSource.clearCart();
  }
  @override
  Future<void> decreaseQuantity(int productId) async {
    await localDataSource.decreaseQuantity(productId);
  }
  @override
  Future<List<CartEntity>> getRemoteCart() async {
    return await remoteDataSource.getCart();
  }
}

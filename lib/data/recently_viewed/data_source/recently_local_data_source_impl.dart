import 'dart:convert';
import 'package:fork_up/data/home/model/product_model.dart';
import 'package:fork_up/data/recently_viewed/data_source/recently_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentlyViewedLocalDataSourceImpl
    implements RecentlyViewedLocalDataSource {
  final SharedPreferences prefs;

  RecentlyViewedLocalDataSourceImpl(this.prefs);

  static const key = 'RECENTLY_VIEWED';

  @override
  Future<List<Product>> getProducts() async {
    final jsonString = prefs.getString(key);

    if (jsonString == null) return [];

    final List decoded = jsonDecode(jsonString);

    return decoded.map((e) => Product.fromJson(e)).toList();
  }

  @override
  Future<void> addProducts(List<Product> products) async {
    final jsonList = products.map((e) => e.toJson()).toList();

    await prefs.setString(key, jsonEncode(jsonList));
  }

  @override
  Future<void> clear() async {
    await prefs.remove(key);
  }
}

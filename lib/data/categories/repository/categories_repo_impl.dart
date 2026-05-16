import 'package:fork_up/data/categories/data_source/categories_remote_data_source.dart';
import 'package:fork_up/data/home/model/mapper/category_mapper.dart';
import 'package:fork_up/domain/categories/repository/categories_repo.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';

class CategoriesRepositoryImpl implements CategoriesRepo {
  final CategoriesRemoteDataSource remote;

  CategoriesRepositoryImpl(this.remote);

  @override
  Future<CategoriesResponseEntity> getCategories() async {
    final result = await remote.getCategories();
    return result.toEntity();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fork_up/core/providers/app_provider.dart';
import 'package:fork_up/data/categories/data_source/categories_remote_data_source.dart';
import 'package:fork_up/data/categories/data_source/categories_remote_data_source_impl.dart';
import 'package:fork_up/data/categories/repository/categories_repo_impl.dart';
import 'package:fork_up/domain/categories/repository/categories_repo.dart';
import 'package:fork_up/domain/categories/use_case/categories_use_case.dart';
import 'package:fork_up/domain/home/entity/category_entity.dart';


class CategoriesNotifier extends AsyncNotifier<CategoriesResponseEntity>{
  @override
  Future<CategoriesResponseEntity> build() async{
    return getCategories();
  }
  Future<CategoriesResponseEntity>getCategories()async{
    state = const  AsyncLoading();
    final useCase = ref.read(categoriesUseCaseProvider);
    return await useCase();
  }

}

final categoriesDataSourceProvider = Provider<CategoriesRemoteDataSource>((ref){
  return CategoriesRemoteDataSourceImpl(ref.read(dioProvider));
});
final categoriesRepoProvider = Provider<CategoriesRepo>((ref){
  return CategoriesRepositoryImpl(ref.read(categoriesDataSourceProvider));
});
final categoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref){
  return GetCategoriesUseCase(ref.read(categoriesRepoProvider));
});
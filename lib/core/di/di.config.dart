// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:fork_up/core/di/di.dart' as _i986;
import 'package:fork_up/data/home/data_source/home_remote_data_source.dart'
    as _i117;
import 'package:fork_up/data/home/data_source/home_remote_data_source_impl.dart'
    as _i725;
import 'package:fork_up/data/home/repository/home_repo_impl.dart' as _i689;
import 'package:fork_up/domain/home/repository/home_repo.dart' as _i1007;
import 'package:fork_up/domain/home/use_case/home_use_case.dart' as _i567;
import 'package:fork_up/presentation/home/cubit/home_cubit.dart' as _i700;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i117.HomeRemoteDataSource>(
      () => _i725.HomeRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1007.HomeRepo>(
      () => _i689.HomeRepositoryImpl(gh<_i117.HomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i567.GetHomeDataUseCase>(
      () => _i567.GetHomeDataUseCase(gh<_i1007.HomeRepo>()),
    );
    gh.factory<_i700.HomeCubit>(
      () => _i700.HomeCubit(gh<_i567.GetHomeDataUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i986.RegisterModule {}

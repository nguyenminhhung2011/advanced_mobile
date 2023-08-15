// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i8;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i6;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i7;
import '../components/widgets/setting_layout/controller/setting_bloc.dart'
    as _i9;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i5;
import 'modules/data_source_module.dart' as _i10;

const String _prod = 'prod';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dataSourceModule = _$DataSourceModule();
  gh.factory<_i3.CloundinaryService>(() => _i3.CloundinaryService());
  gh.factory<_i4.Dio>(
    () => dataSourceModule.dioProd(),
    registerFor: {_prod},
  );
  gh.factory<_i5.ImagePicService>(() => _i5.ImagePicService());
  gh.factory<_i6.SettingUseCase>(() => _i6.SettingUseCase());
  gh.factory<_i7.TestUiBloc>(() => _i7.TestUiBloc());
  gh.factory<_i8.AuthApi>(() => _i8.AuthApi(gh<_i4.Dio>()));
  gh.factory<_i9.SettingBloc>(() => _i9.SettingBloc(gh<_i6.SettingUseCase>()));
  return getIt;
}

class _$DataSourceModule extends _i10.DataSourceModule {}

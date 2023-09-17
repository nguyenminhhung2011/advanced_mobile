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
    as _i12;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i15;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i9;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i14;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i17;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i11;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i13;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i16;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i10;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i18;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i19;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i6;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i20;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i22;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i23;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i7;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i8;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i21;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i5;
import 'modules/data_source_module.dart' as _i24;

const String _prod = 'prod';

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
  gh.factory<_i7.SplashBloc>(() => _i7.SplashBloc());
  gh.factory<_i8.TestUiBloc>(() => _i8.TestUiBloc());
  gh.factory<_i9.TutorApi>(() => _i9.TutorApi(gh<_i4.Dio>()));
  gh.factory<_i10.TutorRepositories>(
      () => _i11.TutorRepositoriesImpl(gh<_i9.TutorApi>()));
  gh.factory<_i12.AuthApi>(() => _i12.AuthApi(gh<_i4.Dio>()));
  gh.factory<_i13.AuthRepository>(
      () => _i14.AuthRepositoryImpl(gh<_i12.AuthApi>()));
  gh.factory<_i15.CourseApi>(() => _i15.CourseApi(gh<_i4.Dio>()));
  gh.factory<_i16.CourseRepositories>(
      () => _i17.CourseRepositoriesImpl(gh<_i15.CourseApi>()));
  gh.factory<_i18.HomeUseCase>(
      () => _i18.HomeUseCase(gh<_i16.CourseRepositories>()));
  gh.factory<_i19.LoginUseCase>(
      () => _i19.LoginUseCase(gh<_i13.AuthRepository>()));
  gh.factory<_i20.RegisterBloc>(
      () => _i20.RegisterBloc(login: gh<_i19.LoginUseCase>()));
  gh.factory<_i21.SettingBloc>(
      () => _i21.SettingBloc(gh<_i6.SettingUseCase>()));
  gh.factory<_i22.AuthBloc>(
      () => _i22.AuthBloc(login: gh<_i19.LoginUseCase>()));
  gh.factory<_i23.HomeBloc>(
      () => _i23.HomeBloc(homeUseCase: gh<_i18.HomeUseCase>()));
  return getIt;
}

class _$DataSourceModule extends _i24.DataSourceModule {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i14;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i17;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i10;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i16;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i19;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i12;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i15;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i18;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i11;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i20;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i21;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i7;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i13;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i22;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i25;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i26;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i8;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i9;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i24;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i23;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i6;
import 'modules/data_source_module.dart' as _i27;

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
  gh.factory<_i4.DashboardBloc>(() => _i4.DashboardBloc());
  gh.factory<_i5.Dio>(
    () => dataSourceModule.dioProd(),
    registerFor: {_prod},
  );
  gh.factory<_i6.ImagePicService>(() => _i6.ImagePicService());
  gh.factory<_i7.SettingUseCase>(() => _i7.SettingUseCase());
  gh.factory<_i8.SplashBloc>(() => _i8.SplashBloc());
  gh.factory<_i9.TestUiBloc>(() => _i9.TestUiBloc());
  gh.factory<_i10.TutorApi>(() => _i10.TutorApi(gh<_i5.Dio>()));
  gh.factory<_i11.TutorRepositories>(
      () => _i12.TutorRepositoriesImpl(gh<_i10.TutorApi>()));
  gh.factory<_i13.TutorShowUseCase>(
      () => _i13.TutorShowUseCase(gh<_i11.TutorRepositories>()));
  gh.factory<_i14.AuthApi>(() => _i14.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i15.AuthRepository>(
      () => _i16.AuthRepositoryImpl(gh<_i14.AuthApi>()));
  gh.factory<_i17.CourseApi>(() => _i17.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i18.CourseRepositories>(
      () => _i19.CourseRepositoriesImpl(gh<_i17.CourseApi>()));
  gh.factory<_i20.HomeUseCase>(
      () => _i20.HomeUseCase(gh<_i18.CourseRepositories>()));
  gh.factory<_i21.LoginUseCase>(
      () => _i21.LoginUseCase(gh<_i15.AuthRepository>()));
  gh.factory<_i22.RegisterBloc>(
      () => _i22.RegisterBloc(login: gh<_i21.LoginUseCase>()));
  gh.factory<_i23.SettingBloc>(
      () => _i23.SettingBloc(gh<_i7.SettingUseCase>()));
  gh.factory<_i24.TutorShowBloc>(
      () => _i24.TutorShowBloc(tutorShowUseCase: gh<_i13.TutorShowUseCase>()));
  gh.factory<_i25.AuthBloc>(
      () => _i25.AuthBloc(login: gh<_i21.LoginUseCase>()));
  gh.factory<_i26.HomeBloc>(
      () => _i26.HomeBloc(homeUseCase: gh<_i20.HomeUseCase>()));
  return getIt;
}

class _$DataSourceModule extends _i27.DataSourceModule {}

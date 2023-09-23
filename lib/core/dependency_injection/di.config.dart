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

import '../../clean_architectures/data/datasource/remote/app/app_api.dart'
    as _i14;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i17;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i20;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i10;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i16;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i19;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i22;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i12;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i34;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i15;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i18;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i21;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i11;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i23;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i24;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i26;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i7;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i13;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i28;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i25;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i30;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i31;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i32;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i33;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i8;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i9;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i35;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i29;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i27;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i6;
import 'modules/data_source_module.dart' as _i36;

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
  gh.factory<_i14.AppApi>(() => _i14.AppApi(gh<_i5.Dio>()));
  gh.factory<_i15.AppRepositories>(
      () => _i16.AppRepositoriesImpl(gh<_i14.AppApi>()));
  gh.factory<_i17.AuthApi>(() => _i17.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i18.AuthRepository>(
      () => _i19.AuthRepositoryImpl(gh<_i17.AuthApi>()));
  gh.factory<_i20.CourseApi>(() => _i20.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i21.CourseRepositories>(
      () => _i22.CourseRepositoriesImpl(gh<_i20.CourseApi>()));
  gh.factory<_i23.HomeUseCase>(
      () => _i23.HomeUseCase(gh<_i21.CourseRepositories>()));
  gh.factory<_i24.LoginUseCase>(
      () => _i24.LoginUseCase(gh<_i18.AuthRepository>()));
  gh.factory<_i25.RegisterBloc>(
      () => _i25.RegisterBloc(login: gh<_i24.LoginUseCase>()));
  gh.factory<_i26.SearchTutorUseCase>(() => _i26.SearchTutorUseCase(
        gh<_i15.AppRepositories>(),
        gh<_i11.TutorRepositories>(),
      ));
  gh.factory<_i27.SettingBloc>(
      () => _i27.SettingBloc(gh<_i7.SettingUseCase>()));
  gh.factory<_i28.TutorDetailUseCase>(
      () => _i28.TutorDetailUseCase(gh<_i11.TutorRepositories>()));
  gh.factory<_i29.TutorShowBloc>(
      () => _i29.TutorShowBloc(tutorShowUseCase: gh<_i13.TutorShowUseCase>()));
  gh.factory<_i30.AuthBloc>(
      () => _i30.AuthBloc(login: gh<_i24.LoginUseCase>()));
  gh.factory<_i31.HomeBloc>(
      () => _i31.HomeBloc(homeUseCase: gh<_i23.HomeUseCase>()));
  gh.factory<_i32.SearchTutorBloc>(() =>
      _i32.SearchTutorBloc(searchTutorUseCase: gh<_i26.SearchTutorUseCase>()));
  gh.factoryParam<_i33.SearchTutorResultBloc, _i34.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i33.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i26.SearchTutorUseCase>(),
          ));
  gh.factoryParam<_i35.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i35.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i28.TutorDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i36.DataSourceModule {}

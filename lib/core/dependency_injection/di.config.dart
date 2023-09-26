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
    as _i20;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i23;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i26;
import '../../clean_architectures/data/datasource/remote/review/review_api.dart'
    as _i7;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i13;
import '../../clean_architectures/data/datasource/remote/user/user_api.dart'
    as _i17;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i22;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i25;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i28;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i9;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i15;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i19;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i41;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i21;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i24;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i27;
import '../../clean_architectures/domain/repositories/review_repositories.dart'
    as _i8;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i14;
import '../../clean_architectures/domain/repositories/user_repositories.dart'
    as _i18;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i29;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i30;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i32;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i10;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i16;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i34;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i31;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i36;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i37;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i38;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i39;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i40;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i11;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i12;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i42;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i35;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i33;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i6;
import 'modules/data_source_module.dart' as _i43;

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
  gh.factory<_i7.ReviewApi>(() => _i7.ReviewApi(gh<_i5.Dio>()));
  gh.factory<_i8.ReviewRepositories>(
      () => _i9.ReviewRepositoriesImpl(gh<_i7.ReviewApi>()));
  gh.factory<_i10.SettingUseCase>(() => _i10.SettingUseCase());
  gh.factory<_i11.SplashBloc>(() => _i11.SplashBloc());
  gh.factory<_i12.TestUiBloc>(() => _i12.TestUiBloc());
  gh.factory<_i13.TutorApi>(() => _i13.TutorApi(gh<_i5.Dio>()));
  gh.factory<_i14.TutorRepositories>(
      () => _i15.TutorRepositoriesImpl(gh<_i13.TutorApi>()));
  gh.factory<_i16.TutorShowUseCase>(
      () => _i16.TutorShowUseCase(gh<_i14.TutorRepositories>()));
  gh.factory<_i17.UserApi>(() => _i17.UserApi(gh<_i5.Dio>()));
  gh.factory<_i18.UserRepositories>(
      () => _i19.UserRepositoriesImpl(gh<_i17.UserApi>()));
  gh.factory<_i20.AppApi>(() => _i20.AppApi(gh<_i5.Dio>()));
  gh.factory<_i21.AppRepositories>(
      () => _i22.AppRepositoriesImpl(gh<_i20.AppApi>()));
  gh.factory<_i23.AuthApi>(() => _i23.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i24.AuthRepository>(
      () => _i25.AuthRepositoryImpl(gh<_i23.AuthApi>()));
  gh.factory<_i26.CourseApi>(() => _i26.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i27.CourseRepositories>(
      () => _i28.CourseRepositoriesImpl(gh<_i26.CourseApi>()));
  gh.factory<_i29.HomeUseCase>(
      () => _i29.HomeUseCase(gh<_i27.CourseRepositories>()));
  gh.factory<_i30.LoginUseCase>(
      () => _i30.LoginUseCase(gh<_i24.AuthRepository>()));
  gh.factory<_i31.RegisterBloc>(
      () => _i31.RegisterBloc(login: gh<_i30.LoginUseCase>()));
  gh.factory<_i32.SearchTutorUseCase>(() => _i32.SearchTutorUseCase(
        gh<_i21.AppRepositories>(),
        gh<_i14.TutorRepositories>(),
      ));
  gh.factory<_i33.SettingBloc>(
      () => _i33.SettingBloc(gh<_i10.SettingUseCase>()));
  gh.factory<_i34.TutorDetailUseCase>(() => _i34.TutorDetailUseCase(
        gh<_i14.TutorRepositories>(),
        gh<_i8.ReviewRepositories>(),
        gh<_i18.UserRepositories>(),
      ));
  gh.factory<_i35.TutorShowBloc>(
      () => _i35.TutorShowBloc(tutorShowUseCase: gh<_i16.TutorShowUseCase>()));
  gh.factory<_i36.AuthBloc>(
      () => _i36.AuthBloc(login: gh<_i30.LoginUseCase>()));
  gh.factory<_i37.HomeBloc>(
      () => _i37.HomeBloc(homeUseCase: gh<_i29.HomeUseCase>()));
  gh.factoryParam<_i38.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i38.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i34.TutorDetailUseCase>(),
      ));
  gh.factory<_i39.SearchTutorBloc>(() =>
      _i39.SearchTutorBloc(searchTutorUseCase: gh<_i32.SearchTutorUseCase>()));
  gh.factoryParam<_i40.SearchTutorResultBloc, _i41.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i40.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i32.SearchTutorUseCase>(),
          ));
  gh.factoryParam<_i42.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i42.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i34.TutorDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i43.DataSourceModule {}

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
    as _i23;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i26;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i29;
import '../../clean_architectures/data/datasource/remote/e_boo/e_boo_api.dart'
    as _i6;
import '../../clean_architectures/data/datasource/remote/review/review_api.dart'
    as _i10;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i16;
import '../../clean_architectures/data/datasource/remote/user/user_api.dart'
    as _i20;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i25;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i28;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i31;
import '../../clean_architectures/data/repositories/e_boo_repositories_impl.dart'
    as _i8;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i12;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i18;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i22;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i48;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i24;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i27;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i30;
import '../../clean_architectures/domain/repositories/e_boo_repositories.dart'
    as _i7;
import '../../clean_architectures/domain/repositories/review_repositories.dart'
    as _i11;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i17;
import '../../clean_architectures/domain/repositories/user_repositories.dart'
    as _i21;
import '../../clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart'
    as _i42;
import '../../clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart'
    as _i32;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i33;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i34;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i36;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i13;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i19;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i38;
import '../../clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart'
    as _i39;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i35;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i41;
import '../../clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart'
    as _i51;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart'
    as _i43;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i44;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i45;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i46;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i47;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i14;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i15;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i49;
import '../../clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart'
    as _i50;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i40;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i37;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i9;
import 'modules/data_source_module.dart' as _i52;

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
  gh.factory<_i6.EBooApi>(() => _i6.EBooApi(gh<_i5.Dio>()));
  gh.factory<_i7.EBooRepositories>(
      () => _i8.EBooRepositoriesImpl(gh<_i6.EBooApi>()));
  gh.factory<_i9.ImagePicService>(() => _i9.ImagePicService());
  gh.factory<_i10.ReviewApi>(() => _i10.ReviewApi(gh<_i5.Dio>()));
  gh.factory<_i11.ReviewRepositories>(
      () => _i12.ReviewRepositoriesImpl(gh<_i10.ReviewApi>()));
  gh.factory<_i13.SettingUseCase>(() => _i13.SettingUseCase());
  gh.factory<_i14.SplashBloc>(() => _i14.SplashBloc());
  gh.factory<_i15.TestUiBloc>(() => _i15.TestUiBloc());
  gh.factory<_i16.TutorApi>(() => _i16.TutorApi(gh<_i5.Dio>()));
  gh.factory<_i17.TutorRepositories>(
      () => _i18.TutorRepositoriesImpl(gh<_i16.TutorApi>()));
  gh.factory<_i19.TutorShowUseCase>(
      () => _i19.TutorShowUseCase(gh<_i17.TutorRepositories>()));
  gh.factory<_i20.UserApi>(() => _i20.UserApi(gh<_i5.Dio>()));
  gh.factory<_i21.UserRepositories>(
      () => _i22.UserRepositoriesImpl(gh<_i20.UserApi>()));
  gh.factory<_i23.AppApi>(() => _i23.AppApi(gh<_i5.Dio>()));
  gh.factory<_i24.AppRepositories>(
      () => _i25.AppRepositoriesImpl(gh<_i23.AppApi>()));
  gh.factory<_i26.AuthApi>(() => _i26.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i27.AuthRepository>(
      () => _i28.AuthRepositoryImpl(gh<_i26.AuthApi>()));
  gh.factory<_i29.CourseApi>(() => _i29.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i30.CourseRepositories>(
      () => _i31.CourseRepositoriesImpl(gh<_i29.CourseApi>()));
  gh.factory<_i32.EBooUseCase>(() => _i32.EBooUseCase(
        gh<_i7.EBooRepositories>(),
        gh<_i30.CourseRepositories>(),
      ));
  gh.factory<_i33.HomeUseCase>(
      () => _i33.HomeUseCase(gh<_i30.CourseRepositories>()));
  gh.factory<_i34.LoginUseCase>(
      () => _i34.LoginUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i35.RegisterBloc>(
      () => _i35.RegisterBloc(login: gh<_i34.LoginUseCase>()));
  gh.factory<_i36.SearchTutorUseCase>(() => _i36.SearchTutorUseCase(
        gh<_i24.AppRepositories>(),
        gh<_i17.TutorRepositories>(),
      ));
  gh.factory<_i37.SettingBloc>(
      () => _i37.SettingBloc(gh<_i13.SettingUseCase>()));
  gh.factory<_i38.TutorDetailUseCase>(() => _i38.TutorDetailUseCase(
        gh<_i17.TutorRepositories>(),
        gh<_i11.ReviewRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i39.TutorScheduleUseCase>(() => _i39.TutorScheduleUseCase(
        gh<_i17.TutorRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i40.TutorShowBloc>(
      () => _i40.TutorShowBloc(tutorShowUseCase: gh<_i19.TutorShowUseCase>()));
  gh.factory<_i41.AuthBloc>(
      () => _i41.AuthBloc(login: gh<_i34.LoginUseCase>()));
  gh.factory<_i42.CourseDetailUseCase>(
      () => _i42.CourseDetailUseCase(gh<_i30.CourseRepositories>()));
  gh.factory<_i43.EBooBloc>(
      () => _i43.EBooBloc(eBooUseCase: gh<_i32.EBooUseCase>()));
  gh.factory<_i44.HomeBloc>(
      () => _i44.HomeBloc(homeUseCase: gh<_i33.HomeUseCase>()));
  gh.factoryParam<_i45.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i45.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i38.TutorDetailUseCase>(),
      ));
  gh.factory<_i46.SearchTutorBloc>(() =>
      _i46.SearchTutorBloc(searchTutorUseCase: gh<_i36.SearchTutorUseCase>()));
  gh.factoryParam<_i47.SearchTutorResultBloc, _i48.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i47.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i36.SearchTutorUseCase>(),
          ));
  gh.factoryParam<_i49.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i49.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i38.TutorDetailUseCase>(),
      ));
  gh.factoryParam<_i50.TutorScheduleBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i50.TutorScheduleBloc(
        userId,
        tutorScheduleUseCase: gh<_i39.TutorScheduleUseCase>(),
      ));
  gh.factoryParam<_i51.CourseDetailBloc, dynamic, dynamic>((
    courseId,
    _,
  ) =>
      _i51.CourseDetailBloc(
        courseId,
        courseDetailUseCase: gh<_i42.CourseDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i52.DataSourceModule {}

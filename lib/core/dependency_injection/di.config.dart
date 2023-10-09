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
    as _i22;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i25;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i32;
import '../../clean_architectures/data/datasource/remote/e_boo/e_boo_api.dart'
    as _i6;
import '../../clean_architectures/data/datasource/remote/review/review_api.dart'
    as _i10;
import '../../clean_architectures/data/datasource/remote/schedule/schedule_api.dart'
    as _i13;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i16;
import '../../clean_architectures/data/datasource/remote/user/user_api.dart'
    as _i19;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i24;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i27;
import '../../clean_architectures/data/repositories/boo_repositories_impl.dart'
    as _i30;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i34;
import '../../clean_architectures/data/repositories/e_boo_repositories_impl.dart'
    as _i8;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i12;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i18;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i21;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i58;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i23;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i26;
import '../../clean_architectures/domain/repositories/boo_repositories.dart'
    as _i29;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i33;
import '../../clean_architectures/domain/repositories/e_boo_repositories.dart'
    as _i7;
import '../../clean_architectures/domain/repositories/review_repositories.dart'
    as _i11;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i17;
import '../../clean_architectures/domain/repositories/user_repositories.dart'
    as _i20;
import '../../clean_architectures/domain/usecase/become_tutor/become_tutor_usecase.dart'
    as _i28;
import '../../clean_architectures/domain/usecase/boo/boo_usecase.dart' as _i31;
import '../../clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart'
    as _i50;
import '../../clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart'
    as _i35;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i36;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i37;
import '../../clean_architectures/domain/usecase/ratting_usecase/ratting_usecase.dart'
    as _i38;
import '../../clean_architectures/domain/usecase/reset_pass/reset_pass_usecase.dart'
    as _i40;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i42;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i43;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i46;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i44;
import '../../clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart'
    as _i45;
import '../../clean_architectures/domain/usecase/user_info_usecase/user_info_usecse.dart'
    as _i47;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i39;
import '../../clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart'
    as _i55;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i48;
import '../../clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart'
    as _i49;
import '../../clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart'
    as _i64;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart'
    as _i51;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i52;
import '../../clean_architectures/presentation/ratting/bloc/ratting_bloc.dart'
    as _i53;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i54;
import '../../clean_architectures/presentation/schedule/bloc/schedule_bloc.dart'
    as _i41;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i56;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i57;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i14;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i15;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i60;
import '../../clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart'
    as _i61;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i62;
import '../../clean_architectures/presentation/user_info/views/user_info_bloc.dart'
    as _i63;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i59;
import '../services/cloundinary_service.dart' as _i3;
import '../services/image_pic_service.dart' as _i9;
import 'modules/data_source_module.dart' as _i65;

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
  gh.factory<_i13.ScheduleApi>(() => _i13.ScheduleApi(gh<_i5.Dio>()));
  gh.factory<_i14.SplashBloc>(() => _i14.SplashBloc());
  gh.factory<_i15.TestUiBloc>(() => _i15.TestUiBloc());
  gh.factory<_i16.TutorApi>(() => _i16.TutorApi(gh<_i5.Dio>()));
  gh.factory<_i17.TutorRepositories>(
      () => _i18.TutorRepositoriesImpl(gh<_i16.TutorApi>()));
  gh.factory<_i19.UserApi>(() => _i19.UserApi(gh<_i5.Dio>()));
  gh.factory<_i20.UserRepositories>(
      () => _i21.UserRepositoriesImpl(gh<_i19.UserApi>()));
  gh.factory<_i22.AppApi>(() => _i22.AppApi(gh<_i5.Dio>()));
  gh.factory<_i23.AppRepositories>(
      () => _i24.AppRepositoriesImpl(gh<_i22.AppApi>()));
  gh.factory<_i25.AuthApi>(() => _i25.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i26.AuthRepository>(
      () => _i27.AuthRepositoryImpl(gh<_i25.AuthApi>()));
  gh.factory<_i28.BecomeTutorUseCase>(() => _i28.BecomeTutorUseCase(
        gh<_i20.UserRepositories>(),
        gh<_i23.AppRepositories>(),
      ));
  gh.factory<_i29.BooRepositories>(
      () => _i30.BooRepositoriesImpl(gh<_i13.ScheduleApi>()));
  gh.factory<_i31.BooUseCase>(() => _i31.BooUseCase(
        gh<_i29.BooRepositories>(),
        gh<_i20.UserRepositories>(),
      ));
  gh.factory<_i32.CourseApi>(() => _i32.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i33.CourseRepositories>(
      () => _i34.CourseRepositoriesImpl(gh<_i32.CourseApi>()));
  gh.factory<_i35.EBooUseCase>(() => _i35.EBooUseCase(
        gh<_i7.EBooRepositories>(),
        gh<_i33.CourseRepositories>(),
      ));
  gh.factory<_i36.HomeUseCase>(
      () => _i36.HomeUseCase(gh<_i33.CourseRepositories>()));
  gh.factory<_i37.LoginUseCase>(
      () => _i37.LoginUseCase(gh<_i26.AuthRepository>()));
  gh.factory<_i38.RattingUseCase>(
      () => _i38.RattingUseCase(gh<_i20.UserRepositories>()));
  gh.factory<_i39.RegisterBloc>(
      () => _i39.RegisterBloc(login: gh<_i37.LoginUseCase>()));
  gh.factory<_i40.ResetPassUseCase>(
      () => _i40.ResetPassUseCase(gh<_i26.AuthRepository>()));
  gh.factory<_i41.ScheduleBloc>(
      () => _i41.ScheduleBloc(booUseCase: gh<_i31.BooUseCase>()));
  gh.factory<_i42.SearchTutorUseCase>(() => _i42.SearchTutorUseCase(
        gh<_i23.AppRepositories>(),
        gh<_i17.TutorRepositories>(),
      ));
  gh.factory<_i43.SettingUseCase>(
      () => _i43.SettingUseCase(gh<_i20.UserRepositories>()));
  gh.factory<_i44.TutorDetailUseCase>(() => _i44.TutorDetailUseCase(
        gh<_i17.TutorRepositories>(),
        gh<_i11.ReviewRepositories>(),
        gh<_i20.UserRepositories>(),
      ));
  gh.factory<_i45.TutorScheduleUseCase>(() => _i45.TutorScheduleUseCase(
        gh<_i17.TutorRepositories>(),
        gh<_i20.UserRepositories>(),
      ));
  gh.factory<_i46.TutorShowUseCase>(() => _i46.TutorShowUseCase(
        gh<_i17.TutorRepositories>(),
        gh<_i20.UserRepositories>(),
        gh<_i29.BooRepositories>(),
      ));
  gh.factory<_i47.UserInfoUseCase>(() => _i47.UserInfoUseCase(
        gh<_i20.UserRepositories>(),
        gh<_i23.AppRepositories>(),
      ));
  gh.factory<_i48.AuthBloc>(
      () => _i48.AuthBloc(login: gh<_i37.LoginUseCase>()));
  gh.factory<_i49.BecomeTutorBloc>(() => _i49.BecomeTutorBloc(
        becomeTutorUseCase: gh<_i28.BecomeTutorUseCase>(),
        imagePicService: gh<_i9.ImagePicService>(),
      ));
  gh.factory<_i50.CourseDetailUseCase>(
      () => _i50.CourseDetailUseCase(gh<_i33.CourseRepositories>()));
  gh.factory<_i51.EBooBloc>(
      () => _i51.EBooBloc(eBooUseCase: gh<_i35.EBooUseCase>()));
  gh.factory<_i52.HomeBloc>(
      () => _i52.HomeBloc(homeUseCase: gh<_i36.HomeUseCase>()));
  gh.factoryParam<_i53.RattingBloc, String, dynamic>((
    booId,
    _,
  ) =>
      _i53.RattingBloc(
        booId,
        rattingUseCase: gh<_i38.RattingUseCase>(),
      ));
  gh.factoryParam<_i54.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i54.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i44.TutorDetailUseCase>(),
      ));
  gh.factory<_i55.ResetPassBloc>(
      () => _i55.ResetPassBloc(resetPassUseCase: gh<_i40.ResetPassUseCase>()));
  gh.factory<_i56.SearchTutorBloc>(() =>
      _i56.SearchTutorBloc(searchTutorUseCase: gh<_i42.SearchTutorUseCase>()));
  gh.factoryParam<_i57.SearchTutorResultBloc, _i58.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i57.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i42.SearchTutorUseCase>(),
          ));
  gh.factory<_i59.SettingBloc>(
      () => _i59.SettingBloc(gh<_i43.SettingUseCase>()));
  gh.factoryParam<_i60.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i60.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i44.TutorDetailUseCase>(),
      ));
  gh.factoryParam<_i61.TutorScheduleBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i61.TutorScheduleBloc(
        userId,
        tutorScheduleUseCase: gh<_i45.TutorScheduleUseCase>(),
      ));
  gh.factory<_i62.TutorShowBloc>(
      () => _i62.TutorShowBloc(tutorShowUseCase: gh<_i46.TutorShowUseCase>()));
  gh.factory<_i63.UserInfoBloc>(() => _i63.UserInfoBloc(
        userInfoUseCase: gh<_i47.UserInfoUseCase>(),
        imagePicService: gh<_i9.ImagePicService>(),
      ));
  gh.factoryParam<_i64.CourseDetailBloc, dynamic, dynamic>((
    courseId,
    _,
  ) =>
      _i64.CourseDetailBloc(
        courseId,
        courseDetailUseCase: gh<_i50.CourseDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i65.DataSourceModule {}

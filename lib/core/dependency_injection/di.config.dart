// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i10;
import 'package:injectable/injectable.dart' as _i2;

import '../../clean_architectures/data/datasource/remote/app/app_api.dart'
    as _i25;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i28;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i35;
import '../../clean_architectures/data/datasource/remote/e_boo/e_boo_api.dart'
    as _i6;
import '../../clean_architectures/data/datasource/remote/review/review_api.dart'
    as _i13;
import '../../clean_architectures/data/datasource/remote/schedule/schedule_api.dart'
    as _i16;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i19;
import '../../clean_architectures/data/datasource/remote/user/user_api.dart'
    as _i22;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i27;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i30;
import '../../clean_architectures/data/repositories/boo_repositories_impl.dart'
    as _i33;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i37;
import '../../clean_architectures/data/repositories/e_boo_repositories_impl.dart'
    as _i8;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i15;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i21;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i24;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i63;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i26;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i29;
import '../../clean_architectures/domain/repositories/boo_repositories.dart'
    as _i32;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i36;
import '../../clean_architectures/domain/repositories/e_boo_repositories.dart'
    as _i7;
import '../../clean_architectures/domain/repositories/review_repositories.dart'
    as _i14;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i20;
import '../../clean_architectures/domain/repositories/user_repositories.dart'
    as _i23;
import '../../clean_architectures/domain/usecase/become_tutor/become_tutor_usecase.dart'
    as _i31;
import '../../clean_architectures/domain/usecase/boo/boo_usecase.dart' as _i34;
import '../../clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart'
    as _i54;
import '../../clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart'
    as _i38;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i39;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i40;
import '../../clean_architectures/domain/usecase/main/main_usecase.dart'
    as _i41;
import '../../clean_architectures/domain/usecase/ratting_usecase/ratting_usecase.dart'
    as _i42;
import '../../clean_architectures/domain/usecase/reset_pass/reset_pass_usecase.dart'
    as _i44;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i46;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i47;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i50;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i48;
import '../../clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart'
    as _i49;
import '../../clean_architectures/domain/usecase/user_info_usecase/user_info_usecse.dart'
    as _i51;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i43;
import '../../clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart'
    as _i60;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i52;
import '../../clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart'
    as _i53;
import '../../clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart'
    as _i69;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i4;
import '../../clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart'
    as _i55;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i56;
import '../../clean_architectures/presentation/main/bloc/main_bloc.dart'
    as _i57;
import '../../clean_architectures/presentation/ratting/bloc/ratting_bloc.dart'
    as _i58;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i59;
import '../../clean_architectures/presentation/schedule/bloc/schedule_bloc.dart'
    as _i45;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i61;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i62;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i17;
import '../../clean_architectures/presentation/tes_ui/bloc/test_ui_bloc.dart'
    as _i18;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i65;
import '../../clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart'
    as _i66;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i67;
import '../../clean_architectures/presentation/user_info/views/user_info_bloc.dart'
    as _i68;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i64;
import '../services/cloundinary_service.dart' as _i3;
import '../services/firebase_service.dart' as _i9;
import '../services/image_pic_service.dart' as _i12;
import 'modules/data_source_module.dart' as _i70;

const String _dev = 'dev';
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
    () => dataSourceModule.dioDev(),
    registerFor: {_dev},
  );
  gh.factory<_i5.Dio>(
    () => dataSourceModule.dioProd(),
    registerFor: {_prod},
  );
  gh.factory<_i6.EBooApi>(() => _i6.EBooApi(gh<_i5.Dio>()));
  gh.factory<_i7.EBooRepositories>(
      () => _i8.EBooRepositoriesImpl(gh<_i6.EBooApi>()));
  gh.factory<_i9.FirebaseServices>(() => _i9.FirebaseServices(
        gh<_i10.GoogleSignIn>(),
        gh<_i11.FacebookAuth>(),
      ));
  gh.factory<_i12.ImagePicService>(() => _i12.ImagePicService());
  gh.factory<_i13.ReviewApi>(() => _i13.ReviewApi(gh<_i5.Dio>()));
  gh.factory<_i14.ReviewRepositories>(
      () => _i15.ReviewRepositoriesImpl(gh<_i13.ReviewApi>()));
  gh.factory<_i16.ScheduleApi>(() => _i16.ScheduleApi(gh<_i5.Dio>()));
  gh.factory<_i17.SplashBloc>(() => _i17.SplashBloc());
  gh.factory<_i18.TestUiBloc>(() => _i18.TestUiBloc());
  gh.factory<_i19.TutorApi>(() => _i19.TutorApi(gh<_i5.Dio>()));
  gh.factory<_i20.TutorRepositories>(
      () => _i21.TutorRepositoriesImpl(gh<_i19.TutorApi>()));
  gh.factory<_i22.UserApi>(() => _i22.UserApi(gh<_i5.Dio>()));
  gh.factory<_i23.UserRepositories>(
      () => _i24.UserRepositoriesImpl(gh<_i22.UserApi>()));
  gh.factory<_i25.AppApi>(() => _i25.AppApi(gh<_i5.Dio>()));
  gh.factory<_i26.AppRepositories>(
      () => _i27.AppRepositoriesImpl(gh<_i25.AppApi>()));
  gh.factory<_i28.AuthApi>(() => _i28.AuthApi(gh<_i5.Dio>()));
  gh.factory<_i29.AuthRepository>(() => _i30.AuthRepositoryImpl(
        gh<_i28.AuthApi>(),
        gh<_i9.FirebaseServices>(),
      ));
  gh.factory<_i31.BecomeTutorUseCase>(() => _i31.BecomeTutorUseCase(
        gh<_i23.UserRepositories>(),
        gh<_i26.AppRepositories>(),
      ));
  gh.factory<_i32.BooRepositories>(
      () => _i33.BooRepositoriesImpl(gh<_i16.ScheduleApi>()));
  gh.factory<_i34.BooUseCase>(() => _i34.BooUseCase(
        gh<_i32.BooRepositories>(),
        gh<_i23.UserRepositories>(),
      ));
  gh.factory<_i35.CourseApi>(() => _i35.CourseApi(gh<_i5.Dio>()));
  gh.factory<_i36.CourseRepositories>(
      () => _i37.CourseRepositoriesImpl(gh<_i35.CourseApi>()));
  gh.factory<_i38.EBooUseCase>(() => _i38.EBooUseCase(
        gh<_i7.EBooRepositories>(),
        gh<_i36.CourseRepositories>(),
      ));
  gh.factory<_i39.HomeUseCase>(
      () => _i39.HomeUseCase(gh<_i36.CourseRepositories>()));
  gh.factory<_i40.LoginUseCase>(
      () => _i40.LoginUseCase(gh<_i29.AuthRepository>()));
  gh.factory<_i41.MainUseCase>(() => _i41.MainUseCase(
        gh<_i20.TutorRepositories>(),
        gh<_i36.CourseRepositories>(),
        gh<_i7.EBooRepositories>(),
      ));
  gh.factory<_i42.RattingUseCase>(
      () => _i42.RattingUseCase(gh<_i23.UserRepositories>()));
  gh.factory<_i43.RegisterBloc>(
      () => _i43.RegisterBloc(login: gh<_i40.LoginUseCase>()));
  gh.factory<_i44.ResetPassUseCase>(
      () => _i44.ResetPassUseCase(gh<_i29.AuthRepository>()));
  gh.factory<_i45.ScheduleBloc>(
      () => _i45.ScheduleBloc(booUseCase: gh<_i34.BooUseCase>()));
  gh.factory<_i46.SearchTutorUseCase>(() => _i46.SearchTutorUseCase(
        gh<_i26.AppRepositories>(),
        gh<_i20.TutorRepositories>(),
      ));
  gh.factory<_i47.SettingUseCase>(
      () => _i47.SettingUseCase(gh<_i23.UserRepositories>()));
  gh.factory<_i48.TutorDetailUseCase>(() => _i48.TutorDetailUseCase(
        gh<_i20.TutorRepositories>(),
        gh<_i14.ReviewRepositories>(),
        gh<_i23.UserRepositories>(),
      ));
  gh.factory<_i49.TutorScheduleUseCase>(() => _i49.TutorScheduleUseCase(
        gh<_i20.TutorRepositories>(),
        gh<_i23.UserRepositories>(),
      ));
  gh.factory<_i50.TutorShowUseCase>(() => _i50.TutorShowUseCase(
        gh<_i20.TutorRepositories>(),
        gh<_i23.UserRepositories>(),
        gh<_i32.BooRepositories>(),
      ));
  gh.factory<_i51.UserInfoUseCase>(() => _i51.UserInfoUseCase(
        gh<_i23.UserRepositories>(),
        gh<_i26.AppRepositories>(),
      ));
  gh.factory<_i52.AuthBloc>(
      () => _i52.AuthBloc(login: gh<_i40.LoginUseCase>()));
  gh.factory<_i53.BecomeTutorBloc>(() => _i53.BecomeTutorBloc(
        becomeTutorUseCase: gh<_i31.BecomeTutorUseCase>(),
        imagePicService: gh<_i12.ImagePicService>(),
      ));
  gh.factory<_i54.CourseDetailUseCase>(
      () => _i54.CourseDetailUseCase(gh<_i36.CourseRepositories>()));
  gh.factory<_i55.EBooBloc>(
      () => _i55.EBooBloc(eBooUseCase: gh<_i38.EBooUseCase>()));
  gh.factory<_i56.HomeBloc>(
      () => _i56.HomeBloc(homeUseCase: gh<_i39.HomeUseCase>()));
  gh.factory<_i57.MainBloc>(
      () => _i57.MainBloc(mainUseCase: gh<_i41.MainUseCase>()));
  gh.factoryParam<_i58.RattingBloc, String, dynamic>((
    booId,
    _,
  ) =>
      _i58.RattingBloc(
        booId,
        rattingUseCase: gh<_i42.RattingUseCase>(),
      ));
  gh.factoryParam<_i59.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i59.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i48.TutorDetailUseCase>(),
      ));
  gh.factory<_i60.ResetPassBloc>(
      () => _i60.ResetPassBloc(resetPassUseCase: gh<_i44.ResetPassUseCase>()));
  gh.factory<_i61.SearchTutorBloc>(() =>
      _i61.SearchTutorBloc(searchTutorUseCase: gh<_i46.SearchTutorUseCase>()));
  gh.factoryParam<_i62.SearchTutorResultBloc, _i63.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i62.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i46.SearchTutorUseCase>(),
          ));
  gh.factory<_i64.SettingBloc>(
      () => _i64.SettingBloc(gh<_i47.SettingUseCase>()));
  gh.factoryParam<_i65.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i65.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i48.TutorDetailUseCase>(),
      ));
  gh.factoryParam<_i66.TutorScheduleBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i66.TutorScheduleBloc(
        userId,
        tutorScheduleUseCase: gh<_i49.TutorScheduleUseCase>(),
      ));
  gh.factory<_i67.TutorShowBloc>(
      () => _i67.TutorShowBloc(tutorShowUseCase: gh<_i50.TutorShowUseCase>()));
  gh.factory<_i68.UserInfoBloc>(() => _i68.UserInfoBloc(
        userInfoUseCase: gh<_i51.UserInfoUseCase>(),
        imagePicService: gh<_i12.ImagePicService>(),
      ));
  gh.factoryParam<_i69.CourseDetailBloc, dynamic, dynamic>((
    courseId,
    _,
  ) =>
      _i69.CourseDetailBloc(
        courseId,
        courseDetailUseCase: gh<_i54.CourseDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i70.DataSourceModule {}

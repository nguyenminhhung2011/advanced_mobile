// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;

import '../../clean_architectures/data/datasource/remote/app/app_api.dart'
    as _i23;
import '../../clean_architectures/data/datasource/remote/auth/auth_api.dart'
    as _i26;
import '../../clean_architectures/data/datasource/remote/chat/chat_api.dart'
    as _i33;
import '../../clean_architectures/data/datasource/remote/course/course_api.dart'
    as _i34;
import '../../clean_architectures/data/datasource/remote/e_boo/e_boo_api.dart'
    as _i5;
import '../../clean_architectures/data/datasource/remote/review/review_api.dart'
    as _i12;
import '../../clean_architectures/data/datasource/remote/schedule/schedule_api.dart'
    as _i15;
import '../../clean_architectures/data/datasource/remote/tutor/tutor_api.dart'
    as _i17;
import '../../clean_architectures/data/datasource/remote/user/user_api.dart'
    as _i20;
import '../../clean_architectures/data/repositories/app_repositories_impl.dart'
    as _i25;
import '../../clean_architectures/data/repositories/auth_repositories_impl.dart'
    as _i28;
import '../../clean_architectures/data/repositories/boo_repositories_impl.dart'
    as _i31;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i36;
import '../../clean_architectures/data/repositories/e_boo_repositories_impl.dart'
    as _i7;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i14;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i19;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i22;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i62;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i24;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i27;
import '../../clean_architectures/domain/repositories/boo_repositories.dart'
    as _i30;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i35;
import '../../clean_architectures/domain/repositories/e_boo_repositories.dart'
    as _i6;
import '../../clean_architectures/domain/repositories/review_repositories.dart'
    as _i13;
import '../../clean_architectures/domain/repositories/tutor_repositories.dart'
    as _i18;
import '../../clean_architectures/domain/repositories/user_repositories.dart'
    as _i21;
import '../../clean_architectures/domain/usecase/become_tutor/become_tutor_usecase.dart'
    as _i29;
import '../../clean_architectures/domain/usecase/boo/boo_usecase.dart' as _i32;
import '../../clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart'
    as _i53;
import '../../clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart'
    as _i37;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i38;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i39;
import '../../clean_architectures/domain/usecase/main/main_usecase.dart'
    as _i40;
import '../../clean_architectures/domain/usecase/ratting_usecase/ratting_usecase.dart'
    as _i41;
import '../../clean_architectures/domain/usecase/reset_pass/reset_pass_usecase.dart'
    as _i43;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i45;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i46;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i49;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i47;
import '../../clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart'
    as _i48;
import '../../clean_architectures/domain/usecase/user_info_usecase/user_info_usecse.dart'
    as _i50;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i42;
import '../../clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart'
    as _i59;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i51;
import '../../clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart'
    as _i52;
import '../../clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart'
    as _i68;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i3;
import '../../clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart'
    as _i54;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i55;
import '../../clean_architectures/presentation/main/bloc/main_bloc.dart'
    as _i56;
import '../../clean_architectures/presentation/ratting/bloc/ratting_bloc.dart'
    as _i57;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i58;
import '../../clean_architectures/presentation/schedule/bloc/schedule_bloc.dart'
    as _i44;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i60;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i61;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i16;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i64;
import '../../clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart'
    as _i65;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i66;
import '../../clean_architectures/presentation/user_info/views/user_info_bloc.dart'
    as _i67;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i63;
import '../services/firebase_service.dart' as _i8;
import '../services/image_pic_service.dart' as _i11;
import 'modules/data_source_module.dart' as _i69;

const String _prod = 'prod';
const String _dev = 'dev';

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
  gh.factory<_i3.DashboardBloc>(() => _i3.DashboardBloc());
  gh.factory<_i4.Dio>(
    () => dataSourceModule.dioDev(),
    registerFor: {_dev},
  );
  gh.factory<_i4.Dio>(
    () => dataSourceModule.dioProd(),
    registerFor: {_prod},
  );
  gh.factory<_i5.EBooApi>(() => _i5.EBooApi(gh<_i4.Dio>()));
  gh.factory<_i6.EBooRepositories>(
      () => _i7.EBooRepositoriesImpl(gh<_i5.EBooApi>()));
  gh.factory<_i8.FirebaseServices>(() => _i8.FirebaseServices(
        gh<_i9.GoogleSignIn>(),
        gh<_i10.FacebookAuth>(),
      ));
  gh.factory<_i11.ImagePicService>(() => _i11.ImagePicService());
  gh.factory<_i12.ReviewApi>(() => _i12.ReviewApi(gh<_i4.Dio>()));
  gh.factory<_i13.ReviewRepositories>(
      () => _i14.ReviewRepositoriesImpl(gh<_i12.ReviewApi>()));
  gh.factory<_i15.ScheduleApi>(() => _i15.ScheduleApi(gh<_i4.Dio>()));
  gh.factory<_i16.SplashBloc>(() => _i16.SplashBloc());
  gh.factory<_i17.TutorApi>(() => _i17.TutorApi(gh<_i4.Dio>()));
  gh.factory<_i18.TutorRepositories>(
      () => _i19.TutorRepositoriesImpl(gh<_i17.TutorApi>()));
  gh.factory<_i20.UserApi>(() => _i20.UserApi(gh<_i4.Dio>()));
  gh.factory<_i21.UserRepositories>(
      () => _i22.UserRepositoriesImpl(gh<_i20.UserApi>()));
  gh.factory<_i23.AppApi>(() => _i23.AppApi(gh<_i4.Dio>()));
  gh.factory<_i24.AppRepositories>(
      () => _i25.AppRepositoriesImpl(gh<_i23.AppApi>()));
  gh.factory<_i26.AuthApi>(() => _i26.AuthApi(gh<_i4.Dio>()));
  gh.factory<_i27.AuthRepository>(() => _i28.AuthRepositoryImpl(
        gh<_i26.AuthApi>(),
        gh<_i8.FirebaseServices>(),
      ));
  gh.factory<_i29.BecomeTutorUseCase>(() => _i29.BecomeTutorUseCase(
        gh<_i21.UserRepositories>(),
        gh<_i24.AppRepositories>(),
      ));
  gh.factory<_i30.BooRepositories>(
      () => _i31.BooRepositoriesImpl(gh<_i15.ScheduleApi>()));
  gh.factory<_i32.BooUseCase>(() => _i32.BooUseCase(
        gh<_i30.BooRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i33.ChatApi>(() => _i33.ChatApi(gh<_i4.Dio>()));
  gh.factory<_i34.CourseApi>(() => _i34.CourseApi(gh<_i4.Dio>()));
  gh.factory<_i35.CourseRepositories>(
      () => _i36.CourseRepositoriesImpl(gh<_i34.CourseApi>()));
  gh.factory<_i37.EBooUseCase>(() => _i37.EBooUseCase(
        gh<_i6.EBooRepositories>(),
        gh<_i35.CourseRepositories>(),
      ));
  gh.factory<_i38.HomeUseCase>(
      () => _i38.HomeUseCase(gh<_i35.CourseRepositories>()));
  gh.factory<_i39.LoginUseCase>(
      () => _i39.LoginUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i40.MainUseCase>(() => _i40.MainUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i35.CourseRepositories>(),
        gh<_i6.EBooRepositories>(),
      ));
  gh.factory<_i41.RattingUseCase>(
      () => _i41.RattingUseCase(gh<_i21.UserRepositories>()));
  gh.factory<_i42.RegisterBloc>(
      () => _i42.RegisterBloc(login: gh<_i39.LoginUseCase>()));
  gh.factory<_i43.ResetPassUseCase>(
      () => _i43.ResetPassUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i44.ScheduleBloc>(
      () => _i44.ScheduleBloc(booUseCase: gh<_i32.BooUseCase>()));
  gh.factory<_i45.SearchTutorUseCase>(() => _i45.SearchTutorUseCase(
        gh<_i24.AppRepositories>(),
        gh<_i18.TutorRepositories>(),
      ));
  gh.factory<_i46.SettingUseCase>(
      () => _i46.SettingUseCase(gh<_i21.UserRepositories>()));
  gh.factory<_i47.TutorDetailUseCase>(() => _i47.TutorDetailUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i13.ReviewRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i48.TutorScheduleUseCase>(() => _i48.TutorScheduleUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i49.TutorShowUseCase>(() => _i49.TutorShowUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i21.UserRepositories>(),
        gh<_i30.BooRepositories>(),
      ));
  gh.factory<_i50.UserInfoUseCase>(() => _i50.UserInfoUseCase(
        gh<_i21.UserRepositories>(),
        gh<_i24.AppRepositories>(),
      ));
  gh.factory<_i51.AuthBloc>(
      () => _i51.AuthBloc(login: gh<_i39.LoginUseCase>()));
  gh.factory<_i52.BecomeTutorBloc>(() => _i52.BecomeTutorBloc(
        becomeTutorUseCase: gh<_i29.BecomeTutorUseCase>(),
        imagePicService: gh<_i11.ImagePicService>(),
      ));
  gh.factory<_i53.CourseDetailUseCase>(
      () => _i53.CourseDetailUseCase(gh<_i35.CourseRepositories>()));
  gh.factory<_i54.EBooBloc>(
      () => _i54.EBooBloc(eBooUseCase: gh<_i37.EBooUseCase>()));
  gh.factory<_i55.HomeBloc>(
      () => _i55.HomeBloc(homeUseCase: gh<_i38.HomeUseCase>()));
  gh.factory<_i56.MainBloc>(
      () => _i56.MainBloc(mainUseCase: gh<_i40.MainUseCase>()));
  gh.factoryParam<_i57.RattingBloc, String, dynamic>((
    booId,
    _,
  ) =>
      _i57.RattingBloc(
        booId,
        rattingUseCase: gh<_i41.RattingUseCase>(),
      ));
  gh.factoryParam<_i58.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i58.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i47.TutorDetailUseCase>(),
      ));
  gh.factory<_i59.ResetPassBloc>(
      () => _i59.ResetPassBloc(resetPassUseCase: gh<_i43.ResetPassUseCase>()));
  gh.factory<_i60.SearchTutorBloc>(() =>
      _i60.SearchTutorBloc(searchTutorUseCase: gh<_i45.SearchTutorUseCase>()));
  gh.factoryParam<_i61.SearchTutorResultBloc, _i62.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i61.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i45.SearchTutorUseCase>(),
          ));
  gh.factory<_i63.SettingBloc>(
      () => _i63.SettingBloc(gh<_i46.SettingUseCase>()));
  gh.factoryParam<_i64.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i64.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i47.TutorDetailUseCase>(),
      ));
  gh.factoryParam<_i65.TutorScheduleBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i65.TutorScheduleBloc(
        userId,
        tutorScheduleUseCase: gh<_i48.TutorScheduleUseCase>(),
      ));
  gh.factory<_i66.TutorShowBloc>(
      () => _i66.TutorShowBloc(tutorShowUseCase: gh<_i49.TutorShowUseCase>()));
  gh.factory<_i67.UserInfoBloc>(() => _i67.UserInfoBloc(
        userInfoUseCase: gh<_i50.UserInfoUseCase>(),
        imagePicService: gh<_i11.ImagePicService>(),
      ));
  gh.factoryParam<_i68.CourseDetailBloc, dynamic, dynamic>((
    courseId,
    _,
  ) =>
      _i68.CourseDetailBloc(
        courseId,
        courseDetailUseCase: gh<_i53.CourseDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i69.DataSourceModule {}

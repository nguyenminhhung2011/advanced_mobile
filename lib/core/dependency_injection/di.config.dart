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
    as _i37;
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
import '../../clean_architectures/data/repositories/chat_respositories_impl.dart'
    as _i35;
import '../../clean_architectures/data/repositories/course_repositories_impl.dart'
    as _i39;
import '../../clean_architectures/data/repositories/e_boo_repositories_impl.dart'
    as _i7;
import '../../clean_architectures/data/repositories/review_repositories_impl.dart'
    as _i14;
import '../../clean_architectures/data/repositories/tutor_repositories_impl.dart'
    as _i19;
import '../../clean_architectures/data/repositories/user_repositories_impl.dart'
    as _i22;
import '../../clean_architectures/domain/entities/search_tutor_request/search_tutor_request.dart'
    as _i66;
import '../../clean_architectures/domain/repositories/app_repostiories.dart'
    as _i24;
import '../../clean_architectures/domain/repositories/auth_repositories.dart'
    as _i27;
import '../../clean_architectures/domain/repositories/boo_repositories.dart'
    as _i30;
import '../../clean_architectures/domain/repositories/chat_repositories.dart'
    as _i34;
import '../../clean_architectures/domain/repositories/course_repositories.dart'
    as _i38;
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
import '../../clean_architectures/domain/usecase/chat/chat_usecase.dart'
    as _i36;
import '../../clean_architectures/domain/usecase/course_detail/course_detail_usecase.dart'
    as _i57;
import '../../clean_architectures/domain/usecase/e_boo_usecase/e_boo_usecase.dart'
    as _i40;
import '../../clean_architectures/domain/usecase/home/home_usecase.dart'
    as _i41;
import '../../clean_architectures/domain/usecase/login/login_usecase.dart'
    as _i42;
import '../../clean_architectures/domain/usecase/main/main_usecase.dart'
    as _i43;
import '../../clean_architectures/domain/usecase/ratting_usecase/ratting_usecase.dart'
    as _i44;
import '../../clean_architectures/domain/usecase/reset_pass/reset_pass_usecase.dart'
    as _i47;
import '../../clean_architectures/domain/usecase/search/search_tutor_usecase.dart'
    as _i49;
import '../../clean_architectures/domain/usecase/setting/setting_usecase.dart'
    as _i50;
import '../../clean_architectures/domain/usecase/tutor/tutor_show_usecase.dart'
    as _i53;
import '../../clean_architectures/domain/usecase/tutor_detail_usecase/tutor_detail_usecase.dart'
    as _i51;
import '../../clean_architectures/domain/usecase/tutor_schedule/tutor_schedule_usecase.dart'
    as _i52;
import '../../clean_architectures/domain/usecase/user_info_usecase/user_info_usecse.dart'
    as _i54;
import '../../clean_architectures/presentation/auth/bloc/register/register_bloc.dart'
    as _i46;
import '../../clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart'
    as _i63;
import '../../clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart'
    as _i55;
import '../../clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart'
    as _i56;
import '../../clean_architectures/presentation/chat/recipient/bloc/recipient_bloc.dart'
    as _i45;
import '../../clean_architectures/presentation/course_detail/bloc/course_detail_bloc.dart'
    as _i72;
import '../../clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart'
    as _i3;
import '../../clean_architectures/presentation/e_boo/bloc/e_boo_bloc.dart'
    as _i58;
import '../../clean_architectures/presentation/home/bloc/home_bloc.dart'
    as _i59;
import '../../clean_architectures/presentation/main/bloc/main_bloc.dart'
    as _i60;
import '../../clean_architectures/presentation/ratting/bloc/ratting_bloc.dart'
    as _i61;
import '../../clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart'
    as _i62;
import '../../clean_architectures/presentation/schedule/bloc/schedule_bloc.dart'
    as _i48;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_bloc.dart'
    as _i64;
import '../../clean_architectures/presentation/search_tutor/bloc/search_tutor_result_bloc.dart'
    as _i65;
import '../../clean_architectures/presentation/splash/bloc/slash_bloc.dart'
    as _i16;
import '../../clean_architectures/presentation/tutor_detail/bloc/tutor_detail_bloc.dart'
    as _i68;
import '../../clean_architectures/presentation/tutor_schedule/bloc/tutor_schedule_bloc.dart'
    as _i69;
import '../../clean_architectures/presentation/tutor_views/bloc/tutor_show_bloc.dart'
    as _i70;
import '../../clean_architectures/presentation/user_info/views/user_info_bloc.dart'
    as _i71;
import '../components/layout/setting_layout/controller/setting_bloc.dart'
    as _i67;
import '../services/firebase_service.dart' as _i8;
import '../services/image_pic_service.dart' as _i11;
import 'modules/data_source_module.dart' as _i73;

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
  gh.factory<_i34.ChatRepositories>(
      () => _i35.ChatRepositoriesImpl(gh<_i33.ChatApi>()));
  gh.factory<_i36.ChatUseCase>(
      () => _i36.ChatUseCase(gh<_i34.ChatRepositories>()));
  gh.factory<_i37.CourseApi>(() => _i37.CourseApi(gh<_i4.Dio>()));
  gh.factory<_i38.CourseRepositories>(
      () => _i39.CourseRepositoriesImpl(gh<_i37.CourseApi>()));
  gh.factory<_i40.EBooUseCase>(() => _i40.EBooUseCase(
        gh<_i6.EBooRepositories>(),
        gh<_i38.CourseRepositories>(),
      ));
  gh.factory<_i41.HomeUseCase>(
      () => _i41.HomeUseCase(gh<_i38.CourseRepositories>()));
  gh.factory<_i42.LoginUseCase>(
      () => _i42.LoginUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i43.MainUseCase>(() => _i43.MainUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i38.CourseRepositories>(),
        gh<_i6.EBooRepositories>(),
      ));
  gh.factory<_i44.RattingUseCase>(
      () => _i44.RattingUseCase(gh<_i21.UserRepositories>()));
  gh.factory<_i45.RecipientCubit>(
      () => _i45.RecipientCubit(gh<_i36.ChatUseCase>()));
  gh.factory<_i46.RegisterBloc>(
      () => _i46.RegisterBloc(login: gh<_i42.LoginUseCase>()));
  gh.factory<_i47.ResetPassUseCase>(
      () => _i47.ResetPassUseCase(gh<_i27.AuthRepository>()));
  gh.factory<_i48.ScheduleBloc>(
      () => _i48.ScheduleBloc(booUseCase: gh<_i32.BooUseCase>()));
  gh.factory<_i49.SearchTutorUseCase>(() => _i49.SearchTutorUseCase(
        gh<_i24.AppRepositories>(),
        gh<_i18.TutorRepositories>(),
      ));
  gh.factory<_i50.SettingUseCase>(
      () => _i50.SettingUseCase(gh<_i21.UserRepositories>()));
  gh.factory<_i51.TutorDetailUseCase>(() => _i51.TutorDetailUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i13.ReviewRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i52.TutorScheduleUseCase>(() => _i52.TutorScheduleUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i21.UserRepositories>(),
      ));
  gh.factory<_i53.TutorShowUseCase>(() => _i53.TutorShowUseCase(
        gh<_i18.TutorRepositories>(),
        gh<_i21.UserRepositories>(),
        gh<_i30.BooRepositories>(),
      ));
  gh.factory<_i54.UserInfoUseCase>(() => _i54.UserInfoUseCase(
        gh<_i21.UserRepositories>(),
        gh<_i24.AppRepositories>(),
      ));
  gh.factory<_i55.AuthBloc>(
      () => _i55.AuthBloc(login: gh<_i42.LoginUseCase>()));
  gh.factory<_i56.BecomeTutorBloc>(() => _i56.BecomeTutorBloc(
        becomeTutorUseCase: gh<_i29.BecomeTutorUseCase>(),
        imagePicService: gh<_i11.ImagePicService>(),
      ));
  gh.factory<_i57.CourseDetailUseCase>(
      () => _i57.CourseDetailUseCase(gh<_i38.CourseRepositories>()));
  gh.factory<_i58.EBooBloc>(
      () => _i58.EBooBloc(eBooUseCase: gh<_i40.EBooUseCase>()));
  gh.factory<_i59.HomeBloc>(
      () => _i59.HomeBloc(homeUseCase: gh<_i41.HomeUseCase>()));
  gh.factory<_i60.MainBloc>(
      () => _i60.MainBloc(mainUseCase: gh<_i43.MainUseCase>()));
  gh.factoryParam<_i61.RattingBloc, String, dynamic>((
    booId,
    _,
  ) =>
      _i61.RattingBloc(
        booId,
        rattingUseCase: gh<_i44.RattingUseCase>(),
      ));
  gh.factoryParam<_i62.ReportTutorBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i62.ReportTutorBloc(
        userId,
        tutorDetailUseCase: gh<_i51.TutorDetailUseCase>(),
      ));
  gh.factory<_i63.ResetPassBloc>(
      () => _i63.ResetPassBloc(resetPassUseCase: gh<_i47.ResetPassUseCase>()));
  gh.factory<_i64.SearchTutorBloc>(() =>
      _i64.SearchTutorBloc(searchTutorUseCase: gh<_i49.SearchTutorUseCase>()));
  gh.factoryParam<_i65.SearchTutorResultBloc, _i66.SearchTutorRequest, dynamic>(
      (
    searchTutorRequest,
    _,
  ) =>
          _i65.SearchTutorResultBloc(
            searchTutorRequest,
            searchTutorUseCase: gh<_i49.SearchTutorUseCase>(),
          ));
  gh.factory<_i67.SettingBloc>(
      () => _i67.SettingBloc(gh<_i50.SettingUseCase>()));
  gh.factoryParam<_i68.TutorDetailBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i68.TutorDetailBloc(
        userId,
        tutorDetailUseCase: gh<_i51.TutorDetailUseCase>(),
      ));
  gh.factoryParam<_i69.TutorScheduleBloc, String, dynamic>((
    userId,
    _,
  ) =>
      _i69.TutorScheduleBloc(
        userId,
        tutorScheduleUseCase: gh<_i52.TutorScheduleUseCase>(),
      ));
  gh.factory<_i70.TutorShowBloc>(
      () => _i70.TutorShowBloc(tutorShowUseCase: gh<_i53.TutorShowUseCase>()));
  gh.factory<_i71.UserInfoBloc>(() => _i71.UserInfoBloc(
        userInfoUseCase: gh<_i54.UserInfoUseCase>(),
        imagePicService: gh<_i11.ImagePicService>(),
      ));
  gh.factoryParam<_i72.CourseDetailBloc, dynamic, dynamic>((
    courseId,
    _,
  ) =>
      _i72.CourseDetailBloc(
        courseId,
        courseDetailUseCase: gh<_i57.CourseDetailUseCase>(),
      ));
  return getIt;
}

class _$DataSourceModule extends _i73.DataSourceModule {}

import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/local/preferences.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';

import '../../entities/user/user.dart';

abstract class BaseUseCase<T> {
  BaseUseCase();

  String? get languageCode => CommonAppSettingPref.getLanguage();
  String? get currencyCode => CommonAppSettingPref.getCurrency();
  String? get accessToken => CommonAppSettingPref.getAccessToken();
  String? get appearance => CommonAppSettingPref.getAppearance();
  String? get passCode => CommonAppSettingPref.getPassCode();

  Future<bool>? setLanguageCode({required String langName}) async =>
      CommonAppSettingPref.setLanguage(langName);
  Future<bool>? setPassCode({required String newPassCode}) async =>
      CommonAppSettingPref.setPassCode(newPassCode);

  void removeAccessToken() {
    CommonAppSettingPref.removeAccessToken();
  }

  void removePassCode() {
    CommonAppSettingPref.removePassCode();
  }

  void removeRefreshToken(){
    CommonAppSettingPref.removeRefreshToken();
  }

  void removeExpiredTime(){
    CommonAppSettingPref.removeExpiredTime();
  }

  Future<bool>? setCurrencyCode({required String currencyCode}) async =>
      CommonAppSettingPref.setCurrency(currencyCode);

  Future<bool>? setAppearance({required String appearance}) async =>
      CommonAppSettingPref.setAppearance(appearance);

  Future<User?>? getUserInfo(token) => null;

  Future<User?>? login({
    required String userName,
    required String password,
  }) =>
      null;

  Future<User?>? createUser({
    required String userName,
    required String password,
    User? userCreate,
  }) =>
      null;

  Future<bool>? logOut({required String token}) => null;

  Future<User?>? updateUserInfo({required User newUser}) => null;

  Future<User?>? loginGoogle({String? token}) => null;
  Future<User?>? loginFacebook({String? token}) => null;
  Future<User?>? loginSms({String? token}) => null;

  Future<List<T>>? getAllData({Map<String, dynamic>? queries}) => null;
  Future<T?>? getDataById({required String id}) => null;
  Future<T?>? updateData({required T newData}) => null;
  Future<bool>? deleteData({required T data}) => null;

  ///[Streams] use case

  SingleResult<User?>? loginS({
    required String email,
    required String password,
  }) =>
      null;
}

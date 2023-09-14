import 'package:flutter_base_clean_architecture/clean_architectures/data/models/token/token_model.dart';

class Validator {
  Validator._();

  static const _emailRegExpString =
      r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
      r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';

  static final _emailRegex = RegExp(_emailRegExpString, caseSensitive: false);

  static bool isValidPassword(String password) => password.length >= 6;

  static bool iSValidRePassword(String password, String rePassword) =>
      password == rePassword;

  static bool isValidEmail(String email) => _emailRegex.hasMatch(email);

  static bool isValidUserName(String userName) => userName.length >= 3;

  static bool tokenNull(TokenModel tokenModel) =>
      !(tokenModel.access?.token?.isNotEmpty ?? false) ||
      !(tokenModel.refresh?.token?.isNotEmpty ?? false);
}

import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseServices {
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  FirebaseServices(this._googleSignIn, this._facebookAuth);

  Future<String> googleAuth() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) {
        return "";
      }
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      return googleAuth.accessToken ?? "";
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<String> fbAuth() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login();
      return loginResult.accessToken?.token ?? "";
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }
}

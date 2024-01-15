import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseServices {
  final GoogleSignIn _googleSignIn;
  FirebaseServices(this._googleSignIn);

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
    return "";
  }
}

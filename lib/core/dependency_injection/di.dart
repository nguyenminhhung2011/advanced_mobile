import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';
// import 'di.config.dart';

GetIt injector = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
  externalPackageModulesBefore: [],
)
GetIt configureDependencies({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  injector.registerSingleton<GoogleSignIn>(googleSignIn);
  injector.registerSingleton<FacebookAuth>(FacebookAuth.instance);
  injector.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);
  return init(
    injector,
    environment: environment,
    environmentFilter: environmentFilter,
  );
}

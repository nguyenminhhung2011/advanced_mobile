import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../app_core_factory.dart';
import '../../components/configurations/configurations.dart';

@module
abstract class DataSourceModule {
  @prod
  Dio dioProd() => AppCoreFactory.createDio(
        Configurations.baseUrl,
        // appStorage, sharepreferencess
      );
}

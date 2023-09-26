import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';

abstract class UserRepositories {
  SingleResult<bool> reportUser(
      {required String userId, required String content});
}

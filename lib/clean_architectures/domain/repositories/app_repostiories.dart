import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';

abstract class AppRepositories {
  SingleResult<List<Topic>> getTopics();
}

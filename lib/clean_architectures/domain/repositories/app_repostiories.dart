import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/topic/topic.dart';

abstract class AppRepositories {
  SingleResult<List<Topic>> getTopics();
}

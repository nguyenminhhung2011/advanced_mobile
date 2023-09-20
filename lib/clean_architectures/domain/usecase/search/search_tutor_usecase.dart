import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/app_repostiories.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchTutorUseCase {
  final AppRepositories _appRepositories;
  SearchTutorUseCase(this._appRepositories);

  SingleResult<List<Topic>> getTopics() => _appRepositories.getTopics();
}

import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/topic/topic.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/app_repostiories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/become_tutor/bloc/become_tutor_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class BecomeTutorUseCase {
  final UserRepositories _userRepositories;
  final AppRepositories _appRepositories;
  BecomeTutorUseCase(this._userRepositories, this._appRepositories);

  SingleResult<List<Topic>> getTopics() => _appRepositories.getTopics();

  SingleResult<bool> registeringTutor(
          {required BecomeTutorRequest becomeTutorRequest}) =>
      _userRepositories.becomeTutor(becomeTutorRequest: becomeTutorRequest);
}

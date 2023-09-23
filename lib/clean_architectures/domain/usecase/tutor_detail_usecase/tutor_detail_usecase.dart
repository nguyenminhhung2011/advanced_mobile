import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor_detail/tutor_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/tutor_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class TutorDetailUseCase {
  final TutorRepositories _tutorRepositories;
  TutorDetailUseCase(this._tutorRepositories);

  SingleResult<TutorDetail?> getTutorById({required String userId}) =>
      _tutorRepositories.getTutorById(userId: userId);
}

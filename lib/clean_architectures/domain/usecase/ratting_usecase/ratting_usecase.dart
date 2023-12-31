import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:lettutor/clean_architectures/presentation/ratting/bloc/ratting_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RattingUseCase {
  final UserRepositories _userRepositories;
  RattingUseCase(this._userRepositories);

  SingleResult<bool> rattingTutor(
          {required ReviewTutorRequest reviewTutorRequest}) =>
      _userRepositories.reviewTutor(reviewTutorRequest: reviewTutorRequest);
}

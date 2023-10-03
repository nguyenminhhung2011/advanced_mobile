import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/boo_repositories.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/user_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class BooUseCase {
  final BooRepositories _booRepositories;
  final UserRepositories _userRepositories;
  BooUseCase(this._booRepositories, this._userRepositories);

  SingleResult<Pagination<BooInfo>> getBooInfo({
    required int page,
    required int perPage,
    required DateTime dateTimeLte,
    required bool isHistoryGet,
    String orderBy = 'meeting',
    String sortBy = 'desc',
  }) =>
      _booRepositories.getBooInfo(
          page: page,
          perPage: perPage,
          dateTimeLte: dateTimeLte,
          isHistoryGet: isHistoryGet);
  SingleResult<bool> cancelBooTutor(
          {required List<String> scheduleDetailIds}) =>
      _userRepositories.cancelBooTutor(scheduleDetailIds: scheduleDetailIds);

  SingleResult<bool> updateStudentRequest(
          {required String booId, required String content}) =>
      _userRepositories.updateStudentRequest(booId: booId, content: content);
}

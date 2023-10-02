import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/boo_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class BooUseCase {
  final BooRepositories _booRepositories;
  BooUseCase(this._booRepositories);

  SingleResult<Pagination<BooInfo>> getBooInfo({
    required int page,
    required int perPage,
    required DateTime dateTimeLte,
    String orderBy = 'meeting',
    String sortBy = 'desc',
  }) =>
      _booRepositories.getBooInfo(
          page: page, perPage: perPage, dateTimeLte: dateTimeLte);
}

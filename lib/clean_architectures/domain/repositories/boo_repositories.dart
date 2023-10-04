import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/boo_info/boo_info.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';

abstract class BooRepositories {
  SingleResult<Pagination<BooInfo>> getBooInfo({
    required int page,
    required int perPage,
    required DateTime dateTimeLte,
    required bool isHistoryGet,
    String orderBy = 'meeting',
    String sortBy = 'desc',
  });

  SingleResult<BooInfo?> getUpComingBooInfo({required DateTime dateTime});
}

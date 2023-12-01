import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:lettutor/clean_architectures/domain/entities/pagination/pagination.dart';

abstract class EBooRepositories {
  SingleResult<Pagination<EBoo>> getEBooResponse(
      {required int page, required int size, String? q, String? categoryId});
}

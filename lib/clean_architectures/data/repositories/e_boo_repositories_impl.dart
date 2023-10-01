import 'package:dart_either/dart_either.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/datasource/remote/e_boo/e_boo_api.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/repositories/e_boo_repositories.dart';
import 'package:flutter_base_clean_architecture/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EBooRepositories)
class EBooRepositoriesImpl extends BaseApi implements EBooRepositories {
  final EBooApi _eBooApi;
  EBooRepositoriesImpl(this._eBooApi);

  @override
  SingleResult<Pagination<EBoo>> getEBooResponse({
    required int page,
    required int size,
    String? q,
    String? categoryId,
  }) =>
      SingleResult.fromCallable(
        () async {
          await Future.delayed(const Duration(seconds: 2));
          final body = <String, dynamic>{"page": page, "size": size};
          if (q?.isNotEmpty ?? false) {
            body.addAll({"q": q});
          }
          if (categoryId?.isNotEmpty ?? false) {
            body.addAll({"categoryId": categoryId});
          }
          final response =
              await getStateOf(request: () async => _eBooApi.getEBoos(body));

          if (response is DataFailed) {
            return Either.left(
              AppException(message: response.dioError?.message ?? 'Error'),
            );
          }
          final responseData = response.data;
          if (responseData == null) {
            return Either.left(AppException(message: 'Data null'));
          }
          return Either.right(
            Pagination<EBoo>(
              rows: responseData.eBoos.map((e) => e.toEntity()).toList(),
              count: responseData.count,
              perPage: size,
              currentPage: page,
            ),
          );
        },
      );
}

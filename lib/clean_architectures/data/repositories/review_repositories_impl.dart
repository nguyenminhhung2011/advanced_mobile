import 'package:dart_either/dart_either.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/base_api.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/data_state.dart';
import 'package:lettutor/clean_architectures/data/datasource/remote/review/review_api.dart';
import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:lettutor/clean_architectures/domain/entities/review/review.dart';
import 'package:lettutor/clean_architectures/domain/repositories/review_repositories.dart';
import 'package:lettutor/core/components/network/app_exception.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ReviewRepositories)
class ReviewRepositoriesImpl extends BaseApi implements ReviewRepositories {
  final ReviewApi _reviewApi;
  ReviewRepositoriesImpl(this._reviewApi);
  @override
  SingleResult<Pagination<Review>> getReviews(
          {required int page, required int perPge, required String userId}) =>
      SingleResult.fromCallable(() async {
        final body = {"page": page, "perPage": perPge};
        final response = await getStateOf(
            request: () async => _reviewApi.getReviews(userId, body: body));
        if (response is DataFailed) {
          return Either.left(toErrorMessage(response.dioError));
        }
        final data = response.data;
        if (data == null) {
          return Either.left(
            AppException(message: "Data null"),
          );
        }
        return Either.right(
          Pagination<Review>(
            rows: data.reviews.map((e) => e.toEntity()).toList(),
            count: data.count,
            currentPage: page,
            perPage: perPge,
          ),
        );
      });
}

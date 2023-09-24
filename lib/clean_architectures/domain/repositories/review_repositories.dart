import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/review/review.dart';

abstract class ReviewRepositories {
  SingleResult<Pagination<Review>> getReviews(
      {required int page, required int perPge, required String userId});
}

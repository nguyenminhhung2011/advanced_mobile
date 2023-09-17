import 'package:flutter_base_clean_architecture/clean_architectures/data/models/app_error.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';


abstract class TutorRepositories {
  SingleResult<Pagination<Tutor>> pagFetchTutorsData(
      {required int page, required int perPge});
}

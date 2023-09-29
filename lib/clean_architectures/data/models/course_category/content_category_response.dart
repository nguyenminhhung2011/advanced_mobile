import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_category/course_category_model.dart';

class ContentCategoryResponse {
  final int count;
  final List<CourseCategoryModel> rows;
  ContentCategoryResponse(this.count, this.rows);
  factory ContentCategoryResponse.fromJson(Map<String, dynamic> data) {
    return ContentCategoryResponse(
      (data['count'] as int?) ?? 0,
      data['rows'] != null
          ? ((data['rows']) as List<dynamic>)
              .map((e) => CourseCategoryModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

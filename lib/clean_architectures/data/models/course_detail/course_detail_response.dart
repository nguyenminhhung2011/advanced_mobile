import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_detail/course_detail_model.dart';

class CourseDetailResponse {
  final String message;
  final CourseDetailModel? data;

  CourseDetailResponse(this.message, this.data);

  factory CourseDetailResponse.fromJson(Map<String, dynamic> data) {
    if (data['data'] == null) return CourseDetailResponse("Failed", null);
    return CourseDetailResponse(
      data['message'],
      CourseDetailModel.fromJson(data['data']),
    );
  }
}

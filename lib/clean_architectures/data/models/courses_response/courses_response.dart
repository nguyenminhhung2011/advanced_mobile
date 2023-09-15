import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course/course_model.dart';

class CoursesResponse {
  final String status;
  final int count;
  final List<CourseModel> courses;
  CoursesResponse(this.status, this.count, this.courses);

  factory CoursesResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return CoursesResponse('Error', 0, List.empty());
    return CoursesResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => CourseModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

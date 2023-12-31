import 'package:lettutor/clean_architectures/data/models/app_error.dart';
import 'package:lettutor/clean_architectures/domain/entities/course/course.dart';
import 'package:lettutor/clean_architectures/domain/repositories/course_repositories.dart';
import 'package:injectable/injectable.dart';

@injectable
class CourseDetailUseCase {
  final CourseRepositories _courseRepositories;
  CourseDetailUseCase(this._courseRepositories);

  SingleResult<Course> getCourseDetail({required String courseId}) =>
      _courseRepositories.getCourseDetail(courseId: courseId);
}

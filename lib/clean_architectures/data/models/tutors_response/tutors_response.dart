import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor/tutor_model.dart';

class TutorResponse {
  final int count;
  final List<TutorModel> courses;
  TutorResponse(this.count, this.courses);

  factory TutorResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['tutors'];
    if (cData == null) return TutorResponse(0, List.empty());
    return TutorResponse(
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => TutorModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

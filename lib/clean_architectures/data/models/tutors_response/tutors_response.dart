import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor/tutor_model.dart';

class TutorsResponse {
  final int count;
  final List<TutorModel> tutors;
  final List<String> favTutors;
  TutorsResponse(this.count, this.tutors, this.favTutors);

  factory TutorsResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['tutors'];
    if (cData == null) return TutorsResponse(0, List.empty(), List.empty());
    return TutorsResponse(
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => TutorModel.fromJson(e))
              .toList()
          : List.empty(),
      data['favoriteTutor'] != null
          ? (data['favoriteTutor'] as List<dynamic>)
              .map((e) => e['secondId']?.toString().trim() ?? '')
              .toList()
          : List.empty(),
    );
  }
}

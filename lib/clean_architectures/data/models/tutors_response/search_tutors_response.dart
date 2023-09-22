import 'package:flutter_base_clean_architecture/clean_architectures/data/models/tutor/tutor_model.dart';

class SearchTutorsResponse {
  final int count;
  final List<TutorModel> tutors;

  SearchTutorsResponse(this.count, this.tutors);

  factory SearchTutorsResponse.fromJson(Map<String, dynamic> data) {
    return SearchTutorsResponse(
      (data['count'] as int?) ?? 0,
      data['rows'] != null
          ? ((data['rows']) as List<dynamic>)
              .map((e) => TutorModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

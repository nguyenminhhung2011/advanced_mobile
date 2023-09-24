import 'package:flutter_base_clean_architecture/clean_architectures/data/models/review/review_model.dart';

class ReviewResponse {
  final String status;
  final int count;
  final List<ReviewModel> reviews;
  ReviewResponse(this.status, this.count, this.reviews);

  factory ReviewResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return ReviewResponse('Error', 0, List.empty());
    return ReviewResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => ReviewModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

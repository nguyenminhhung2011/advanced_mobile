import 'package:flutter_base_clean_architecture/clean_architectures/data/models/boo_info/boo_info_model.dart';

class BooResponse {
  final String status;
  final int count;
  final List<BooInfoModel> boos;
  BooResponse(this.status, this.count, this.boos);

  factory BooResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return BooResponse('Error', 0, List.empty());
    return BooResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => BooInfoModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

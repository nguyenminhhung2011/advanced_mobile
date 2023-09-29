
import 'package:flutter_base_clean_architecture/clean_architectures/data/models/e_boo/e_boo_model.dart';

class EBooResponse {
  final String status;
  final int count;
  final List<EBooModel> eBoos;
  EBooResponse(this.status, this.count, this.eBoos);

  factory EBooResponse.fromJson(Map<String, dynamic> data) {
    final cData = data['data'];
    if (cData == null) return EBooResponse('Error', 0, List.empty());
    return EBooResponse(
      data['message']?.toString() ?? 'Error',
      (cData['count'] as int?) ?? 0,
      cData['rows'] != null
          ? ((cData['rows']) as List<dynamic>)
              .map((e) => EBooModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

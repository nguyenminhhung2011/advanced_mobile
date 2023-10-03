import 'package:flutter_base_clean_architecture/clean_architectures/data/models/boo_info/boo_info_model.dart';

class UpComingResponse {
  final String message;
  final List<BooInfoModel> data;

  UpComingResponse(this.message, this.data);

  factory UpComingResponse.fromJson(Map<String, dynamic> data) {
    return UpComingResponse(
      data['message']?.toString() ?? 'Error',
      data['data'] != null
          ? ((data['data']) as List<dynamic>)
              .map((e) => BooInfoModel.fromJson(e))
              .toList()
          : List.empty(),
    );
  }
}

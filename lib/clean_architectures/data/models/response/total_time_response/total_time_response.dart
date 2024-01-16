class TotalTimeResponse {
  final int total;

  TotalTimeResponse(this.total);

  factory TotalTimeResponse.fromJson(Map<String, dynamic> data) {
    return TotalTimeResponse(
      (data['total'] as int?) ?? 0,
    );
  }
}

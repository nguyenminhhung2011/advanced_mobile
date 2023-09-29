import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'e_boo.freezed.dart';

@freezed
class EBoo with _$EBoo {
  const factory EBoo({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    String? level,
    bool? visible,
    String? fileUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<CourseCategory>? categories,
  }) = _EBoo;
}

import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_category_model.g.dart';

@JsonSerializable()
class CourseCategoryModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'key')
  final String? key;

  @JsonKey(name: 'displayOrder')
  final int? displayOrder;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  CourseCategoryModel(
    this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  );

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryModelToJson(this);

  CourseCategory toEntity() => CourseCategory(
        id: id,
        title: title ?? '',
        description: description ?? '',
        key: key,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

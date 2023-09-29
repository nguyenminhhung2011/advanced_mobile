import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_category/course_category_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course_category/course_category.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'e_boo_model.g.dart';

@JsonSerializable()
class EBooModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'level')
  final String? level;

  @JsonKey(name: 'visible')
  final bool? visible;

  @JsonKey(name: 'fileUrl')
  final String? fileUrl;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'categories')
  final List<CourseCategoryModel>? categories;

  EBooModel(
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.visible,
    this.fileUrl,
    this.createdAt,
    this.updatedAt,
    this.categories,
  );

  factory EBooModel.fromJson(Map<String, dynamic> json) =>
      _$EBooModelFromJson(json);

  Map<String, dynamic> toJson() => _$EBooModelToJson(this);

  EBoo toEntity() => EBoo(
        id: id,
        name: name ?? '',
        description: description,
        imageUrl: imageUrl,
        level: level,
        visible: visible,
        fileUrl: fileUrl,
        createdAt: createdAt,
        updatedAt: updatedAt,
        categories: categories?.map((e) => e.toEntity()).toList() ??
            List<CourseCategory>.empty(),
      );
}

import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
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

  @JsonKey(name: 'reason')
  final String? reason;

  @JsonKey(name: 'purpose')
  final String? purpose;

  @JsonKey(name: 'other_details')
  final String? otherDetails;

  @JsonKey(name: 'default_price')
  final int? defaultPrice;

  @JsonKey(name: 'course_price')
  final int? coursePrice;

  @JsonKey(name: 'courseType')
  final String? courseType;

  @JsonKey(name: 'sectionType')
  final String? sectionType;

  @JsonKey(name: 'visible')
  final bool? visible;

  @JsonKey(name: 'displayOrder')
  final int? displayOrder;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  // @JsonKey(name: 'topics')
  // final List<CourseTopicModel>? topics;

  // @JsonKey(name: 'categories')
  // final List<CourseCategoryModel>? categories;

  CourseModel(
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.otherDetails,
    this.defaultPrice,
    this.coursePrice,
    this.courseType,
    this.sectionType,
    this.visible,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
    // this.topics,
    // this.categories,
  );

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  Course toEntity() => Course(
        id: id,
        imageUrl: imageUrl,
        level: level,
        reason: reason,
        purpose: purpose,
        otherDetails: otherDetails,
        createdAt: createdAt,
        updatedAt: updatedAt,
        name: name ?? '',
        description: description ?? '',
        defaultPrice: defaultPrice?.toDouble() ?? 0.0,
        coursePrice: coursePrice?.toDouble() ?? 0.0,
        visible: visible ?? true,
      );
}

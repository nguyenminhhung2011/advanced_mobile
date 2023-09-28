import 'package:flutter_base_clean_architecture/clean_architectures/data/models/course_topic/course_topic_model.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_detail_model.g.dart';

@JsonSerializable()
class CourseDetailModel {
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

  @JsonKey(name: 'topics')
  final List<CourseTopicModel>? topics;

  CourseDetailModel(
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
    this.topics,
  );

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);

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
        topics:
            (topics ?? <CourseTopicModel>[]).map((e) => e.toEntity()).toList(),
      );
}

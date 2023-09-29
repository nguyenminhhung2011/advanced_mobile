import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/skeleton_custom.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () =>
            context.openPageWithRouteAndParams(Routes.courseDetail, course.id),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 5.0,
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: ImageCustom(
                      imageUrl: course.imageUrl ?? ImageConst.baseImageView,
                      isNetworkImage: true,
                      width: 120,
                      height: 120,
                      loadingWidget: SkeletonContainer.rounded(
                        width: 120,
                        height: 120,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.name,
                          style: context.titleMedium
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          course.description,
                          style: context.titleSmall
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                        Row(
                          children: [
                            Text(
                              'Levels',
                              style: context.titleSmall.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              ' ${course.level} . ${course.topics.length} topics',
                              style: context.titleSmall
                                  .copyWith(fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
                        ..removeLast(),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 5.0,
              left: 10.0,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                child: Text(
                  (course.level ?? '0').renderExperienceText,
                  style: context.titleSmall.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      );
}

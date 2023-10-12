import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

class CourseHorizontalItem extends StatelessWidget {
  final Course course;

  final bool isFirstItem;
  const CourseHorizontalItem({
    super.key,
    required this.course,
    required this.isFirstItem,
  });

  EdgeInsetsGeometry get _margin => EdgeInsets.only(
      left: isFirstItem ? 10 : 0, right: 10.0, top: 10.0, bottom: 10.0);

  BorderRadiusGeometry get _radius => BorderRadius.circular(10.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.openPageWithRouteAndParams(Routes.courseDetail, course.id),
      child: Stack(
        children: [
          Container(
            width: context.widthDevice * 0.4,
            height: double.infinity,
            margin: _margin,
            decoration: BoxDecoration(
              borderRadius: _radius,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 5.0,
                )
              ],
              image: DecorationImage(
                image:
                    NetworkImage(course.imageUrl ?? ImageConst.baseImageView),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: context.widthDevice * 0.4,
            height: double.infinity,
            padding: const EdgeInsets.all(10.0),
            margin: _margin,
            decoration:
                BoxDecoration(borderRadius: _radius, color: Colors.black26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(flex: 3, child: SizedBox()),
                Expanded(
                  flex: 1,
                  child: Text(
                    course.name,
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    course.description,
                    style: context.titleSmall.copyWith(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 10.0,
            left: isFirstItem ? 10.0 : 0.0,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Text(
                (course.level ?? '0').renderExperienceText,
                style: context.titleSmall
                    .copyWith(color: Colors.white, fontSize: 11.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

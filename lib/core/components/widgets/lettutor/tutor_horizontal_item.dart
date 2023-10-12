import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/validators.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';

import '../../../../routes/routes.dart';

class TutorHorizontalItem extends StatelessWidget {
  const TutorHorizontalItem({
    super.key,
    required this.data,
    required this.isFirstItem,
  });
  final bool isFirstItem;

  final Tutor data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.openPageWithRouteAndParams(Routes.tutorDetail, data.userId),
      child: Container(
        width: context.widthDevice * 0.55,
        margin: EdgeInsets.only(
            left: isFirstItem ? 10 : 0, right: 10.0, top: 10.0, bottom: 10.0),
        height: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 5.0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: ImageCustom(
                      imageUrl: data.avatar ?? ImageConst.baseImageView,
                      isNetworkImage: true,
                      width: 35.0,
                      height: 35.0,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.name ?? '', style: context.titleSmall),
                        RattingWidgetCustom(
                            rating: data.rating ?? 0.0, itemSize: 10.0)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              flex: 3,
              child: Text(
                data.bio ?? '',
                maxLines: 6,
                style: context.titleSmall
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12.0),
              ),
            ),
            Divider(color: Theme.of(context).primaryColor, thickness: 0.3),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        data.level?.toLowerCase() ?? 'Unknown',
                        style: context.titleSmall
                            .copyWith(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Validator.countryCodeValid(data.country)
                        ? Text(
                            CountryCode.fromCountryCode(
                                  data.country!.toUpperCase(),
                                ).name ??
                                '',
                            style: context.titleSmall.copyWith(fontSize: 12.0),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

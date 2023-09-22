import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/tutor/tutor.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';

class TutorViewCard extends StatelessWidget {
  final Tutor tutor;
  final bool isLiked;
  final Function()? favOnPress;
  const TutorViewCard({
    super.key,
    this.favOnPress,
    this.isLiked = false,
    required this.tutor,
  });

  Widget get favIcon => isLiked
      ? const Icon(Icons.favorite, color: Colors.red)
      : const Icon(Icons.favorite_outline, color: Colors.red);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 5.0)
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: ImageCustom(
                  imageUrl: tutor.avatar ?? ImageConst.baseImageView,
                  isNetworkImage: true,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tutor.name ?? '',
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    if (tutor.country?.isNotEmpty ?? false) ...[
                      Text(
                        Constant.countries[tutor.country!.toUpperCase()] ??
                            'Unknown',
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                    ],
                    RattingWidgetCustom(rating: tutor.rating ?? 0.0)
                  ],
                ),
              ),
              IconButton(onPressed: favOnPress, icon: favIcon)
            ],
          ),
          if (tutor.specialties != null)
            Wrap(
              children: [
                ...tutor.specialties!.split(',').map(
                      (e) => Container(
                        margin: const EdgeInsets.all(2.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: primaryColor.withOpacity(0.2),
                        ),
                        child: Text(
                          e.replaceAll('-', ' '),
                          style: context.titleSmall.copyWith(
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    )
              ],
            ),
          if (tutor.bio != null)
            Text(
              tutor.bio ?? '',
              maxLines: 4,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
                overflow: TextOverflow.fade,
              ),
            ),
          const Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: ButtonCustom(
              borderColor: primaryColor,
              color: Theme.of(context).cardColor,
              enableWidth: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Books ',
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ),
                  Icon(Icons.check, color: primaryColor),
                ],
              ),
              onPress: () {},
            ),
          )
        ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
          ..removeLast(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/e_boo/e_boo.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class EBooHorizontalItem extends StatelessWidget {
  final EBoo eBoo;
  final bool isFirstItem;
  const EBooHorizontalItem({
    super.key,
    required this.eBoo,
    required this.isFirstItem,
  });

  EdgeInsetsGeometry get _margin => EdgeInsets.only(
      left: isFirstItem ? 10 : 0, right: 10.0, top: 10.0, bottom: 10.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthDevice * 0.75,
      height: double.infinity,
      margin: _margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: NetworkImage(eBoo.imageUrl ?? ImageConst.baseImageView),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    eBoo.name,
                    maxLines: 2,
                    style: context.titleSmall
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    eBoo.description ?? '',
                    maxLines: 4,
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).hintColor,
                      fontSize: 12.0,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

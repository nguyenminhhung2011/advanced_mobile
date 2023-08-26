import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/item_view/mixins/item_view_mixin.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> with ItemViewMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

class NotFoundField extends StatelessWidget {
  const NotFoundField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off,
              color: Theme.of(context).primaryColor, size: 30.0),
          const SizedBox(height: 10.0),
          Text(
            'Don\'t have any result',
            style: context.titleMedium.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

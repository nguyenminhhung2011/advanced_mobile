import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

import '../../../constant/image_const.dart';
import '../utils/setting_utils.dart';

class LangCodeShows extends StatefulWidget {
  const LangCodeShows({super.key});

  @override
  State<LangCodeShows> createState() => _LangCodeShowsState();
}

class _LangCodeShowsState extends State<LangCodeShows> {
  @override
  Widget build(BuildContext context) {
    final height = context.heightDevice;
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: height * 0.8,
        minHeight: height * 0.6,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 3.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 10.0),
              ...SettingUtils.locals.map(
                (e) => ListTile(
                  onTap: () => context.popArgs(e.langCode),
                  leading: Image.network(
                    e.image ?? ImageConst.baseImageView,
                    fit: BoxFit.cover,
                    width: 50.0,
                    height: 30.0,
                  ),
                  title: Text(
                    e.name,
                    style: context.titleMedium
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(e.langCode, style: context.titleSmall),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/bloc_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_bloc.dart';

import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/utils/setting_utils.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/dropdown_button_custom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RenderAppBar extends StatefulWidget {
  const RenderAppBar({super.key});

  @override
  State<RenderAppBar> createState() => _RenderAppBarState();
}

class _RenderAppBarState extends State<RenderAppBar> {
  SettingBloc get _settingBloc => context.readSettingBloc;

  Color get primaryColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.school, color: primaryColor, size: 30),
        Text(
          " LetTutor",
          style: context.titleLarge
              .copyWith(fontWeight: FontWeight.bold, color: primaryColor),
        ),
        const Spacer(),
        BlocBuilder<SettingBloc, SettingState>(
          bloc: _settingBloc,
          builder: (ctx, state) {
            final lang = state.data.langCode;
            return SizedBox(
              width: 120,
              child: DropdownButtonCustom<String?>(
                radius: 8.0,
                items: SettingUtils.locals
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.langCode,
                        child: Image.network(
                            e.image ?? ImageConst.baseImageView,
                            width: 40,
                            height: 20),
                      ),
                    )
                    .toList(),
                value: lang,
                onChange: (lang) => _settingBloc.add(
                  SettingEvent.updateLangCode(
                      langCode: lang ?? SettingUtils.locals.first.langCode),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

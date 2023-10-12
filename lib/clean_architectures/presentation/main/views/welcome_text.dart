import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/bloc_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  SettingBloc get _settingBloc => context.readSettingBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      bloc: _settingBloc,
      builder: (ctx, state) {
        final currentUser = state.data.currentUser;
        if (currentUser == null) {
          return const SizedBox();
        }
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text.rich(TextSpan(
              style: context.titleSmall,
              children: [
                TextSpan(
                  text: S.of(context).welcomeToLetTutor,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(text: ' ${currentUser.name}')
              ],
            )));
      },
    );
  }
}

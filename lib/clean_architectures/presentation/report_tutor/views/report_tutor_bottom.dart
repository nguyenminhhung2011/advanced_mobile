import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lettutor/app_coordinator.dart';
import 'package:lettutor/clean_architectures/presentation/auth/base/auth_mixin.dart';
import 'package:lettutor/clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart';
import 'package:lettutor/core/components/extensions/context_extensions.dart';
import 'package:lettutor/core/components/widgets/button_custom.dart';
import 'package:lettutor/core/components/widgets/header_custom.dart';
import 'package:lettutor/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class ReportTutorBottom extends StatefulWidget {
  const ReportTutorBottom({super.key});

  @override
  State<ReportTutorBottom> createState() => _ReportTutorBottomState();
}

class _ReportTutorBottomState extends State<ReportTutorBottom> with AuthMixin {
  ReportTutorBloc get _bloc => BlocProvider.of<ReportTutorBloc>(context);

  Object? listen;

  final _contentController = TextEditingController();

  EdgeInsets get _horizontalEdgeInsets =>
      const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    listen ??= _bloc.state$.flatMap(handleState).collect();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 3.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).hintColor.withOpacity(0.2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        HeaderTextCustom(
          headerText: S.of(context).reportTutor,
          padding: _horizontalEdgeInsets,
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: _horizontalEdgeInsets,
          child: _reportTextView(),
        ),
        const SizedBox(height: 40),
        StreamBuilder<bool?>(
          stream: _bloc.loading$,
          builder: (ctx, sS) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonCustom(
                height: 45.0,
                radius: 5.0,
                loading: sS.data ?? false,
                onPress: () => _bloc.reportTutor(_contentController.text),
                child: Text(
                  S.of(context).report,
                  style: context.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _reportTextView() {
    return TextField(
      minLines: 4,
      controller: _contentController,
      decoration: textFieldDecoration(
        suffixIcon: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        errorText: null,
      ).copyWith(
        hintText: S.of(context).reportTutor,
        hintStyle:
            context.titleSmall.copyWith(color: Theme.of(context).hintColor),
      ), // InputDecoration(
      keyboardType: TextInputType.emailAddress,
      maxLines: 8,
      style: context.titleSmall,
      onChanged: (text) {},
      textInputAction: TextInputAction.next,
      onSubmitted: (_) {},
    );
  }

  Stream handleState(state) async* {
    if (state is ReportTutorSuccess) {
      log("🌟[Report tutor] success");
      context.popArgs(true);
      return;
    }
    if (state is ReportTutorFailed) {
      log(state.toString());
      return;
    }
  }
}

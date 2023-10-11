import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/report_tutor/bloc/report_tutor_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class ReportTutorBottom extends StatefulWidget {
  const ReportTutorBottom({super.key});

  @override
  State<ReportTutorBottom> createState() => _ReportTutorBottomState();
}

class _ReportTutorBottomState extends State<ReportTutorBottom> {
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
    return Container(
      width: context.widthDevice,
      constraints: BoxConstraints(
        maxHeight: context.heightDevice * 0.35,
        minHeight: context.heightDevice * 0.3,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: StreamBuilder<bool?>(
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
        ),
        body: ListView(
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
            Padding(
              padding: _horizontalEdgeInsets,
              child: TextField(
                controller: _contentController,
                decoration:  InputDecoration(
                  hintText: S.of(context).addReportContent,
                ),
              ),
            ),
          ],
        ),
      ),
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

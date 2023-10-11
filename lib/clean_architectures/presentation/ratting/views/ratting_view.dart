import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/user/user.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/bloc/ratting_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/ratting/bloc/ratting_state.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/bloc_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/layout/setting_layout/controller/setting_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/appbar.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/loading_page.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/text_form_field_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class RattingView extends StatefulWidget {
  const RattingView({super.key});

  @override
  State<RattingView> createState() => _RattingViewState();
}

class _RattingViewState extends State<RattingView> {
  RattingBloc get _bloc => BlocProvider.of<RattingBloc>(context);

  SettingBloc get _settingBloc => context.readSettingBloc;

  User? get _currentUser => _settingBloc.data.currentUser;

  Object? listen;

  final TextEditingController _controller = TextEditingController();

  final ValueNotifier<double> _rating = ValueNotifier<double>(1.0);

  @override
  void initState() {
    super.initState();
    listen ??= _bloc.state$.flatMap(handleState).collect();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const SizedBox();
    }

    var headerStyle = context.titleMedium.copyWith(fontWeight: FontWeight.bold);

    return StreamBuilder(
      stream: _bloc.loading$,
      builder: (ctx, sS) {
        final loading = sS.data ?? false;
        return Stack(
          children: [
            _body(context, headerStyle),
            if (loading)
              Container(
                color: Colors.black45,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: _loading(),
              )
          ],
        );
      },
    );
  }

  Center _loading() {
    return Center(
      child: StyleLoadingWidget.foldingCube
          .renderWidget(size: 40.0, color: Theme.of(context).primaryColor),
    );
  }

  Scaffold _body(BuildContext context, TextStyle headerStyle) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: ButtonCustom(
          height: 50,
          child: Text(S.of(context).addReview),
          onPress: () => _bloc.rattingTutor(
              _currentUser!.id, _controller.text, _rating.value),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          AppbarCustom(
            backgroundColor: Theme.of(context).primaryColor,
            title: [
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              Text(S.of(context).addReview, style: context.headerAppBarTextStyle),
              IconButton(onPressed: () {}, icon: const SizedBox())
            ].expand((element) => [element, const Spacer()]).toList()
              ..removeLast(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                HeaderTextCustom(
                  headerText: S.of(context).rateStar,
                  textStyle: headerStyle,
                ),
                ValueListenableBuilder<double>(
                  valueListenable: _rating,
                  builder: (context, rating, child) {
                    return RattingWidgetCustom(
                      rating: rating,
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemSize: 50.0,
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
                TextFieldCustom(
                  paddingLeft: 15.0,
                  paddingRight: 15.0,
                  maxLines: 10,
                  headerText: S.of(context).yourReview,
                  headerTextStyle: headerStyle,
                  spacingText: 10.0,
                  hintStyle: context.titleMedium,
                  hintText: S.of(context).writeYourReview,
                  textStyle: context.titleMedium,
                  controller: _controller,
                ),
              ]
                  .expand((element) => [const SizedBox(height: 20.0), element])
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Stream handleState(state) async* {
    if (state is RattingSuccess) {
      context.showSnackBar("🌟[Ratting tutor] success");
      log("🌟[Ratting tutor] success");
      return;
    }
    if (state is RattingFailed) {
      context.showSnackBar("🌟[Ratting tutor] ${state.toString()}");
      return;
    }
  }
}

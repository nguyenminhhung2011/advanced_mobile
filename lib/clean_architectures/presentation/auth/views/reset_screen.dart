import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/base/auth_mixin.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/reset/reset_pass_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_button.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with AuthMixin, DidChangeDependencies {
  final _emailController = TextEditingController();

  ResetPassBloc get _bloc => BlocProvider.of<ResetPassBloc>(context);

  Object? listen;

  @override
  void initState() {
    super.initState();
    didChangeDependencies$
        .exhaustMap((_) => _bloc.state$)
        .exhaustMap(handleState)
        .collect();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Stream handleState(state) async* {
    if (state is ResetPassSuccess) {
      context.showSnackBar("🌟[ Reset password ] Email send success");
      return;
    }
    if (state is ResetPassFailed) {
      context.showSnackBar(state.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        title: Text(
          "Reset password",
          style: context.titleLarge.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).resetPassword,
              textAlign: TextAlign.center,
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              S.of(context).pleaseEnterYourEmail,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).hintColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            _emailTextField(),
            const SizedBox(height: 20.0),
            _resetButton(),
            const SizedBox(height: kToolbarHeight),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return StreamBuilder<String?>(
      stream: _bloc.emailError$,
      builder: (context, snapshot) {
        return TextField(
          controller: _emailController,
          decoration: textFieldDecoration(
            suffixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(end: 8.0),
              child: Icon(Icons.email),
            ),
            labelText: S.of(context).email,
            errorText: snapshot.data,
          ), // InputDecoration(
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          style: const TextStyle(fontSize: 16.0),
          onChanged: _bloc.emailedChanged,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }

  Widget _resetButton() {
    return ProgressButton(
      call: () async {
        _bloc.submitReset();
        return true;
      },
      width: 300,
      isAnimation: true,
      textInside: S.of(context).resetPassword,
      radius: 10.0,
    );
  }
}

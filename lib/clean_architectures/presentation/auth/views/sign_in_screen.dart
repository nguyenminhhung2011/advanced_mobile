import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/base/auth_mixin.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/widgets/render_app_bar.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_button.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with
        DidChangeDependencies,
        AuthMixin,
        // DisposableMixin,
        SingleTickerProviderStateMixin<SignInScreen> {
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  final _passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obscureText = ValueNotifier(true);

  AuthBloc get _bloc => BlocProvider.of<AuthBloc>(context);

  Object? listenState;

  @override
  void initState() {
    _emailController = TextEditingController(text: 'phhai@ymail.co');
    _passwordController = TextEditingController(text: '12345');
    super.initState();
    didChangeDependencies$
        .exhaustMap((_) => _bloc.message$)
        .exhaustMap(handleState)
        .collect();
    // .disposedBy();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _onChangeObscureText() {
    _obscureText.value = !_obscureText.value;
  }

  @override
  void didChangeDependencies() {
    ///[Call] when get change value from Provider or parent widget
    super.didChangeDependencies();
    // listenState ??= _bloc.message$.flatMap(handleState).collect();
  }

  Stream<void> handleState(state) async* {
    if (state is SignInSuccessMessage) {
      log("[Sign in] success");
      await delay(100);
      yield null;
      // ignore: use_build_context_synchronously
      await context.pushAndRemoveAll(Routes.dashboard);
      return;
    }
    if (state is SignInErrorMessage) {
      context.showSnackBar("🐛 [Sign in] error ${state.toString()}");
      return;
    }
    if (state is InvalidFormatMessage) {
      context.showSnackBar("🐛 [Sign in] invalid format message");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: const RenderAppBar(),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Image.asset(
            ImageConst.loginImages,
            width: double.infinity,
            height: context.heightDevice * 0.36,
          ),
          const SizedBox(height: 20.0),
          Text(
            S.of(context).sayHellToYour,
            textAlign: TextAlign.center,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              S.of(context).beComeFluent,
              style: context.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: _emailTextField(),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            child: _passwordField(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () =>
                      context.openListPageWithRoute(Routes.resetPassword),
                  child: Text(
                    S.of(context).forGotPassword,
                    style: context.titleSmall.copyWith(color: primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.openListPageWithRoute(Routes.register),
                  child: Text(S.of(context).signUp, style: context.titleSmall),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_loginButton()],
          ),
          const SizedBox(height: 5.0),
          Text(S.of(context).orContinue,
              textAlign: TextAlign.center, style: context.titleSmall),
          const SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...[
                ImageConst.facebook,
                ImageConst.google,
              ].mapIndexed(
                (index, e) => IconButton(
                  onPressed: () {
                    if (index == 1) {
                      _bloc.submitGoogleSignIn();
                    }
                  },
                  icon: SvgPicture.asset(e),
                ),
              )
            ],
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return StreamBuilder<String?>(
      stream: _bloc.passwordError$,
      builder: (context, snapshot) {
        return ValueListenableBuilder<bool>(
          valueListenable: _obscureText,
          builder: (_, obscureText, __) {
            return TextField(
              obscureText: obscureText,
              controller: _passwordController,
              onChanged: _bloc.passwordChanged,
              autofillHints: const [AutofillHints.password],
              decoration: textFieldDecoration(
                suffixIcon: GestureDetector(
                  onTap: _onChangeObscureText,
                  child: Icon(
                    obscureText ? Icons.lock_outline : Icons.lock_open_sharp,
                  ),
                ),
                labelText: S.of(context).password,
                errorText: snapshot.data,
              ),
            );
          },
        );
      },
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
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _loginButton() {
    return ProgressButton(
      call: () async {
        _bloc.submitSignIn();
        return true;
      },
      width: 300,
      isAnimation: true,
      textInside: S.of(context).logIn,
      radius: 10.0,
    );
  }
}

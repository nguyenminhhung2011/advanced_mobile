import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/sign_in/auth_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_button.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with
        DidChangeDependencies,
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
    _emailController = TextEditingController(text: 'hung@gmail.com');
    _passwordController = TextEditingController(text: '20112002');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _emailTextField(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _passwordField(),
          ),
          const SizedBox(height: 32.0),
          _loginButton(),
          const Spacer(),
        ],
      ),
    );
  }

  Stream<void> handleState(state) async* {
    if (state is SignInSuccessMessage) {
      log("[Sign in] success");
      await delay(100);
      yield null;
      // ignore: use_build_context_synchronously
      await context.pushAndRemoveAll(Routes.testUi);
      return;
    }
    if (state is SignInErrorMessage) {
      log("[Sign in] error ${state.toString()}");
      return;
    }
    if (state is InvalidFormatMessage) {
      log("[Sign in] invalid format message");
      return;
    }
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
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsetsDirectional.only(end: 8.0),
                  child: Icon(Icons.password),
                ),
                labelText: 'Password',
                errorText: snapshot.data,
                suffixIcon: GestureDetector(
                  onTap: _onChangeObscureText,
                  child: Icon(
                    obscureText ? Icons.lock_outline : Icons.lock_open_sharp,
                  ),
                ),
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
          autocorrect: true,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(end: 8.0),
              child: Icon(Icons.email),
            ),
            labelText: 'Email',
            errorText: snapshot.data,
          ),
          keyboardType: TextInputType.emailAddress,
          maxLines: 1,
          style: const TextStyle(fontSize: 16.0),
          onChanged: _bloc.emailedChanged,
          textInputAction: TextInputAction.next,
          autofocus: true,
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
      textInside: 'Tap me',
      radius: 10.0,
    );
  }
}

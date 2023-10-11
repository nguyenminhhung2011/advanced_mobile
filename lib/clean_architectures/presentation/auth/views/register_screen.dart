import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/base/auth_mixin.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_state.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/widgets/render_app_bar.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_button.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with AuthMixin {
  RegisterBloc get _bloc => BlocProvider.of<RegisterBloc>(context);

  Object? listen;

  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  late TextEditingController _rePasswordController;

  final ValueNotifier<bool> _obscureText = ValueNotifier(true);

  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'phhai@ymail.co');
    _passwordController = TextEditingController(text: '12345');
    _rePasswordController = TextEditingController();
    listen ??= _bloc.state$.flatMap(handleState).collect();
  }

  void _onChangeObscureText() {
    _obscureText.value = !_obscureText.value;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  Stream handleState(RegisterState state) async* {
    if (state is RegisterSuccess) {
      context
          .showSnackBar("🌟[Register] register success please verify account");
      return;
    }
    if (state is RegisterError) {
      context.showSnackBar("🐛[Register error] ${state.toString()}");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: scaffoldBackgroundColor,
        title: const RenderAppBar(),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 20.0),
          Image.asset(
            ImageConst.loginImages,
            height: context.heightDevice * 0.3,
            width: double.infinity,
          ),
          const SizedBox(height: 20.0),
          Text(
            S.of(context).signUpToUse,
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
              S.of(context).registerAccountToUse,
              style: context.titleSmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15.0),
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
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_signUpButton()],
          ),
        ],
      ),
    );
  }

  // Widget _rePasswordField() {}

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
          onChanged: _bloc.emailChanged,
          textInputAction: TextInputAction.next,
          onSubmitted: (_) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _signUpButton() {
    return ProgressButton(
      call: () async {
        _bloc.submitRegister();
        return true;
      },
      width: 300,
      isAnimation: true,
      textInside: S.of(context).registerAccount,
      radius: 10.0,
    );
  }
}

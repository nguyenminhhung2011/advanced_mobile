import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/base/auth_mixin.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/bloc/register/register_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/auth/views/widgets/render_app_bar.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with AuthMixin, DidChangeDependencies {
  RegisterBloc get _bloc => BlocProvider.of<RegisterBloc>(context);
  late TextEditingController _emailController;

  late TextEditingController _passwordController;

  final _passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obscureText = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'phhai@ymail.co');
    _passwordController = TextEditingController(text: '12345');
    didChangeDependencies$
        .exhaustMap((_) => _bloc.state$)
        .exhaustMap(handleState)
        .collect();
  }

  void _onChangeObscureText() {
    _obscureText.value = !_obscureText.value;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Stream handleState(state) async* {}

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
            'Sign up to use letTutor',
            textAlign: TextAlign.center,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: primaryColor,
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
                labelText: 'Password',
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
            labelText: 'Email',
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
}

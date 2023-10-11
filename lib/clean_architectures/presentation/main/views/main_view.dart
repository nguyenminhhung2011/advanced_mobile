import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/bloc/main_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/main/views/welcome_text.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  Color get _primaryColor => Theme.of(context).primaryColor;

  MainBloc get _bloc => BlocProvider.of<MainBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.school, color: _primaryColor),
            Text(
              ' letTutor',
              style: context.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: _primaryColor,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
      body: ListView(
        children: [
          WelcomeText(),
          _bannerField(context),
        ],
      ),
    );
  }

  Padding _bannerField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: context.heightDevice * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _primaryColor,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              ImageConst.bannerImage,
              height: context.heightDevice * 0.23,
            ),
          )
        ],
      ),
    );
  }
}

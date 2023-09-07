import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:universal_platform/universal_platform.dart';

enum StyleLoadingWidget { rotatingPlain, foldingCube, none }

extension StyleLoadingWidgetExtension on StyleLoadingWidget {
  Widget renderWidget({
    Color? color,
    double size = 50.0,
    AnimationController? animationController,
  }) =>
      switch (this) {
        StyleLoadingWidget.rotatingPlain =>
          SpinKitRotatingCircle(color: color, size: size),
        StyleLoadingWidget.foldingCube => SpinKitFoldingCube(
            color: color, size: size, controller: animationController),
        _ => const SizedBox(),
      };
}

class LoadingPage extends StatefulWidget {
  final bool loading;

  final Widget page;

  final StyleLoadingWidget? styleLoadingWidget;

  final Color? circularColor;

  const LoadingPage({
    Key? key,
    required this.loading,
    required this.page,
    this.styleLoadingWidget,
    this.circularColor,
  }) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Color get _circularColor =>
      widget.circularColor ?? Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          widget.page,
          if (widget.loading)
            Container(
              color: Colors.black45,
              width: context.widthDevice,
              height: context.heightDevice,
              child: Center(
                child: _loadingRender(),
              ),
            )
        ],
      ),
    );
  }

  Widget _loadingRender() =>
      widget.styleLoadingWidget?.renderWidget(color: _circularColor) ??
      SizedBox(
        child: UniversalPlatform.isAndroid
            ? CircularProgressIndicator(color: _circularColor)
            : CupertinoActivityIndicator(color: _circularColor),
      );
}

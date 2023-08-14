import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/avartat_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/config/setting_config.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/layout/setting_layout.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../clean_architectures/domain/entities/user/user.dart';
import '../controller/setting_bloc.dart';

typedef GetUserData = Future<User?> Function();

class SettingScreen extends StatefulWidget {
  final SettingConfig settingConfig;
  final GetUserData? getUserCall;
  const SettingScreen({
    super.key,
    this.getUserCall,
    required this.settingConfig,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // style
  Color get _backgroundColor => Theme.of(context).scaffoldBackgroundColor;
  Color get _appBarColor =>
      widget.settingConfig.appBarColor ?? Theme.of(context).primaryColor;
  SettingLayout get _layout => widget.settingConfig.settingLayout;
  List<dynamic> get _items => widget.settingConfig.listView;
  String get _behindImage =>
      widget.settingConfig.behindBackground ?? ImageConst.baseImageView;

  EdgeInsets get _padding => widget.settingConfig.edgeInsets;
  bool get _enableUser => widget.settingConfig.enableUser;
  double get _shadowElevation => widget.settingConfig.shadowElevation;
  double get _elevationCard => widget.settingConfig.elevationCard;

  Widget get _forwardIcon =>
      const Icon(Icons.arrow_forward_ios_sharp, size: 17.0);

  //data
  SettingBloc get _settingController => context.read<SettingBloc>();
  Appearance get _appearance => _settingController.data.appearance;
  User? get _currentUser => _settingController.data.currentUser;

  @override
  void initState() {
    _settingController.add(const SettingEvent.started());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _langeChange() {}
  void _currenciedChange({required Currencies currencies}) => _settingController
      .add(SettingEvent.updateCurrencies(currencies: currencies));
  void _appearanceChange() {
    _settingController.add(const SettingEvent.updateAppearance());
    if (_appearance.isDark) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
  }

  void _listenStateChange(_, SettingState state) {
    state.maybeWhen(orElse: () {});
  }

  @override
  Widget build(BuildContext context) => _renderBody();

  Widget _renderBody() {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: _listenStateChange,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _backgroundColor,
          body: switch (_layout) {
            SettingLayout.view1 => _view1(),
            _ => const SizedBox()
          },
        );
      },
    );
  }

  CustomScrollView _view1() {
    return CustomScrollView(
      slivers: [
        _renderAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              if (_enableUser) ..._renderUserField,
              Padding(
                padding: _padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).generalSettings,
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    ..._items
                        .map((e) => _renderItem(value: e))
                        .expand((e) => [e, const SizedBox(height: 3.0)])
                        .toList()
                      ..removeLast()
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  List<Widget> get _renderUserField {
    final logText =
        _currentUser != null ? S.of(context).logOut : S.of(context).logIn;
    final logIcon = _currentUser != null ? Icons.restart_alt : Icons.person;
    return [
      const SizedBox(height: 10.0),
      if (_currentUser != null) ...[
        ...<String>[
          _currentUser?.userName ?? '',
          _currentUser?.email ?? '',
          _currentUser?.phoneNumber ?? '',
          _currentUser?.creditCardNumber ?? '',
        ].mapIndexed(
          (index, text) {
            if (text.isEmpty) {
              return const SizedBox();
            }
            final icon = index == 0
                ? AvatarWidget(
                    imageUrl:
                        _currentUser?.photoUrl ?? ImageConst.baseImageView,
                  )
                : Icon(
                    switch (index) {
                      1 => Icons.email,
                      2 => Icons.phone,
                      _ => CupertinoIcons.creditcard_fill,
                    },
                    size: 24.0);
            return Card(
              color: _backgroundColor,
              elevation: 0,
              child: ListTile(
                onTap: () {},
                leading: icon,
                title: Text(text),
                trailing: _forwardIcon,
              ),
            );
          },
        ),
      ],
      Card(
        color: _backgroundColor,
        elevation: 0,
        child: ListTile(
          onTap: () {},
          leading: Icon(logIcon),
          title: Text(logText, style: context.titleMedium),
          trailing: _forwardIcon,
        ),
      ),
    ];
  }

  Widget _renderAppBar() {
    return SliverAppBar(
      backgroundColor: _appBarColor,
      leading: const SizedBox(),
      floating: true,
      pinned: true,
      expandedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          S.of(context).settings,
          style: context.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        background: GradientImage(
            image: _behindImage, shadowElevation: _shadowElevation),
      ),
    );
  }

  Widget _renderItem({required String value}) {
    IconData? icon;
    Widget? iconWidget;
    String? title;
    Widget? titleWidget;
    Widget? trailing;
    final headTitleStyle = context.titleMedium;
    final subTitleStyle = context.titleSmall.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
    );
    Function()? onPress;
    switch (value) {
      case 'appearance':
        {
          onPress = _appearanceChange;
          icon = _appearance.isDark
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined;
          titleWidget = Text(S.of(context).appearance, style: headTitleStyle);
          trailing = Text(
            _appearance.isDark
                ? S.of(context).darkTheme
                : S.of(context).lightTheme,
            style: subTitleStyle,
          );
        }
      case 'lang':
        {
          onPress = () {};
          icon = Icons.language;
          titleWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).languages, style: headTitleStyle),
              Text('English', style: subTitleStyle),
            ],
          );
        }
      case 'currencies':
        {
          onPress = () {};
          icon = Icons.price_change;
          titleWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).currencies, style: headTitleStyle),
              Text('USD', style: subTitleStyle),
            ],
          );
        }
      case 'notifications':
        {
          icon = CupertinoIcons.bell;
          title = S.of(context).notifications;
          trailing = Switch(
            value: true,
            onChanged: (value) {},
            activeColor: Theme.of(context).primaryColor,
          );
        }
      case 'security':
        {
          onPress = () {};
          titleWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).lockAndSecurity, style: headTitleStyle),
              Text(S.of(context).codeAndFingerPrints, style: subTitleStyle),
            ],
          );
          icon = Icons.security;
        }
      case 'about':
        icon = Icons.people;
        title = S.of(context).about;
        onPress = () {};
      default:
      //do something here
    }
    return _settingItem(
      onTap: onPress,
      icon: icon,
      titleWidget: titleWidget,
      title: title,
      trailing: trailing,
      iconWidget: iconWidget,
    );
  }

  Widget _settingItem({
    IconData? icon,
    Widget? iconWidget,
    String? title,
    Widget? titleWidget,
    Widget? trailing,
    required Function()? onTap,
  }) {
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).cardColor,
      elevation: _elevationCard,
      child: ListTile(
        onTap: onTap,
        leading: iconWidget ?? Icon(icon ?? Icons.person, size: 24),
        title: titleWidget ?? Text(title ?? '', style: context.titleMedium),
        trailing: trailing ?? _forwardIcon,
      ),
    );
  }
}

class GradientImage extends StatelessWidget {
  const GradientImage({
    super.key,
    required String image,
    required double shadowElevation,
  })  : _image = image,
        _shadowElevation = shadowElevation;

  final String _image;
  final double _shadowElevation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ImageCustom(imageUrl: _image, isNetworkImage: true),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: List.generate(
              2,
              (index) =>
                  Theme.of(context).shadowColor.withOpacity(_shadowElevation),
            )),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:collection/collection.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/avartat_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/config/setting_config.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/layout/setting_layout.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/setting_layout/utils/setting_utils.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../clean_architectures/domain/entities/user/user.dart';
import '../controller/setting_bloc.dart';

class SettingScreen extends StatefulWidget {
  final SettingConfig settingConfig;
  const SettingScreen({
    super.key,
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
    _settingController.add(const SettingEvent.getUserInfo());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _langChange() async {
    final lang = await context.langBottom();
    if (lang.isNotEmpty) {
      _settingController.add(SettingEvent.updateLangCode(langCode: lang));
    }
  }

  void _currenciedChange({required Currencies currencies}) => _settingController
      .add(SettingEvent.updateCurrencies(currencies: currencies));

  void _appearanceChange() {
    _settingController.add(const SettingEvent.updateAppearance());
  }

  void _onSecurityChange(bool value) async {
    final passCodeChange =
        await context.openPageWithRouteAndParams(Routes.passCode, '');
    if (passCodeChange is String && (passCodeChange.isNotEmpty)) {
      if (value) {
        _settingController.add(
          SettingEvent.updatePassCode(newPassCode: passCodeChange),
        );
      } else {
        _settingController.add(const SettingEvent.removePassCoe());
      }
    }
  }

  void _listenStateChange(_, SettingState state) {
    state.maybeWhen(
      orElse: () {
        // do nothing
      },
      logOutSuccess: (_) {
        final popUpRoutes = widget.settingConfig.popUpRoute;
        if (popUpRoutes?.isNotEmpty ?? false) {
          context.popUntil(popUpRoutes!);
        }
      },
      updateAppearanceSuccess: (data) {
        if (_appearance.isDark) {
          AdaptiveTheme.of(context).setDark();
        } else {
          AdaptiveTheme.of(context).setLight();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => _renderBody();

  Widget _renderBody() {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: _listenStateChange,
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
        return Scaffold(
          backgroundColor: _backgroundColor,
          body: switch (_layout) {
            SettingLayout.view1 => _view1(),
            _ => _view2()
          },
        );
      },
    );
  }

  Widget _view2() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: context.heightDevice * 0.3,
            child: GradientImage(
              image: _behindImage,
              shadowElevation: _shadowElevation,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.4),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [..._renderUserField],
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor.withOpacity(0.4),
                        blurRadius: 5.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      ..._items
                          .map((e) => _renderItem(value: e))
                          .expand((e) => [e, const SizedBox(height: 3.0)])
                          .toList()
                        ..removeLast(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
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
                      ..removeLast(),
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
                    width: 40.0,
                    height: 40.0,
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
              margin: EdgeInsets.symmetric(horizontal: _padding.horizontal / 2),
              color: Colors.transparent,
              elevation: 0,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                onTap: index == 0 ? () {} : null,
                leading: icon,
                title: Text(text),
                trailing: null,
              ),
            );
          },
        ),
      ],
      Card(
        margin: EdgeInsets.symmetric(
            horizontal: _padding.horizontal / 2, vertical: 2.0),
        color: Theme.of(context).cardColor,
        elevation: 0.3,
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
        expandedTitleScale: 1.5,
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
          onPress = _langChange;
          icon = Icons.language;
          titleWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).languages, style: headTitleStyle),
              Text(
                SettingUtils.locals
                    .firstWhere(
                        (e) => _settingController.data.langCode == e.langCode)
                    .name,
                style: subTitleStyle,
              ),
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
          titleWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).lockAndSecurity, style: headTitleStyle),
              Text(S.of(context).codeAndFingerPrints, style: subTitleStyle),
            ],
          );
          trailing = Switch(
            value: _settingController.data.passCode.isNotEmpty,
            onChanged: _onSecurityChange,
            activeColor: Theme.of(context).primaryColor,
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
    this.height,
  })  : _image = image,
        _shadowElevation = shadowElevation;

  final String _image;
  final double _shadowElevation;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height ?? double.infinity,
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

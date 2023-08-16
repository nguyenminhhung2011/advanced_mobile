import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import '../widgets/setting_layout/layout/setting_layout.dart';

class SettingConfig {
  String? behindBackground;

  String? popUpRoute;

  Color? appBarColor;

  SettingLayout settingLayout = SettingLayout.view1;
  // Coder can set don't display user in setting screen
  bool enableUser = true;

  EdgeInsets edgeInsets = const EdgeInsets.all(5.0);

  List<dynamic> listView = <dynamic>[];

  double shadowElevation = 0.2;

  double elevationCard = 0.3;

  SettingConfig({
    this.appBarColor,
    this.behindBackground,
    this.popUpRoute,
    this.enableUser = false,
    this.elevationCard = 0.3,
    this.shadowElevation = 0.2,
    this.edgeInsets = const EdgeInsets.all(5.0),
    required this.settingLayout,
    required this.listView,
  });

  SettingConfig.fromJson(dynamic data) {
    enableUser = data['enable_user'] ?? false;

    settingLayout =
        SettingLayout.fromString(data['setting_layout']?.toString() ?? 'view1');

    behindBackground =
        data['behindBackground']?.toString() ?? ImageConst.baseImageView;

    appBarColor = data['app_bar_color'].toString().toColor();

    if (data['list_view'] != null && data['list_view'] is List<dynamic>) {
      List<dynamic> views = data['list_view'];
      listView.clear();
      views.forEach((element) => listView.add(element));
    }

    edgeInsets = EdgeInsets.symmetric(
      horizontal: data['hPadding'] ?? 5.0,
      vertical: data['vPadding'] ?? 5.0,
    );

    shadowElevation = data['shadow_elevation'] ?? 0.2;

    elevationCard = data['elevation_card'] ?? 0.3;

    popUpRoute = data['pop_up_route'] ?? '';
  }
}

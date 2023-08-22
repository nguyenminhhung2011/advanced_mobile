enum SettingLayout {
  view1,
  view2;

  static SettingLayout fromString(String text) => switch (text) {
        'view1' => SettingLayout.view1,
        _ => SettingLayout.view2,
      };
}

extension SettingExtension on SettingLayout {
  bool get isView1 => this == SettingLayout.view1;
  bool get isView2 => this == SettingLayout.view2;
}

import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';

class AppConfig {
  // Splash
  String imageUrl = ImageConst.baseImageView;
  // Onboard

  // Constructor
  AppConfig({
    this.imageUrl = ImageConst.baseImageView,
  });

  AppConfig.fromJson(dynamic data) {
    imageUrl = data['image_url'].toString();
  }
}

import 'dart:ui';

class HYSizeFit {
  static double physicalWidth = 0.0;
  static double physicalHeight = 0.0;
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double dpr = 0.0;
  static double statueHeight = 0.0;

  static double rpx = 0.0;
  static double px = 0.0;

  static void initialize() {
    //物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    //获取dpr
    dpr = window.devicePixelRatio;
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

    //状态栏高度
    statueHeight = window.padding.top / dpr;

    //计算rpx的大小
    rpx = screenWidth / 750;
    px = screenWidth / 750 * 2;
  }

  //适配IOS
  static double setRpx(double size) {
    return rpx * size;
  }

  static double setPx(double size) {
    return px * size;
  }
}

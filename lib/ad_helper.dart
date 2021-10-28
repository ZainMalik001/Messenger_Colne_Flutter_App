import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-9660057632578564/9992971447";
    } else if (Platform.isIOS) {
      return "ca-app-pub-9660057632578564/4285828124";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

}
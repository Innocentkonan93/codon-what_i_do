// ignore_for_file: file_names

import 'dart:io';

class AdService{
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-2802381755115526/9482802491';
    }else if(Platform.isIOS) {
      return "ca-app-pub-2802381755115526/5160414101";
    }else{
      throw UnsupportedError('Unsupported Platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-2802381755115526/3465679742';
    } else if (Platform.isIOS) {
      return "ca-app-pub-2802381755115526/5824249774";
    } else {
      throw UnsupportedError('Unsupported Platform');
    }
  }
}





// ignore_for_file: file_names

import 'package:google_mobile_ads/google_mobile_ads.dart';

// ignore: camel_case_types
class addmobHelper{
  static String get bannerUnit => 'ca-app-pub-7497476289867437/1784905794';

  static initialization(){
    if(MobileAds.instance==null){
      MobileAds.instance.initialize();
    }
  }

  static getBannerAdd(){
    // ignore: unnecessary_new
    BannerAd bad = new BannerAd(size: AdSize.banner, adUnitId: 'ca-app-pub-7497476289867437/1784905794', listener: BannerAdListener(
      onAdClosed: (Ad ad)=>{
        print("add closed")
      },
      onAdLoaded: (Ad ad)=>{
        print("add Loaded")
      },
      onAdFailedToLoad: (Ad add,LoadAdError err)=>{
        print("add loading error"),
        print(err)
      }
    ),request: AdRequest());
    bad.load();
    return bad;
  }
}
// ignore_for_file: file_names

import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/addMobHelper.dart';

class NewsDetailsPage extends StatefulWidget {
  final String data;
  const NewsDetailsPage({ Key? key ,required this.data}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  bool isexist=false;

  @override
  void initState() {
    
    super.initState();
  }

  // BannerAd? bannerAd;
  // bool addIsLoded = false;

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   bannerAd = BannerAd(size: AdSize.banner, adUnitId: "ca-app-pub-7497476289867437/1784905794", listener: BannerAdListener(
  //     onAdLoaded: (ad)=>{
  //       setState((){
  //         addIsLoded=true;
  //       })
  //     },
  //     onAdFailedToLoad: (ad,error)=>{
  //       ad.dispose(),
  //       print(error)
  //     }
  //   ),
  //   request: AdRequest()
  //   );
  //   bannerAd!.load();
  // }


  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(jsonDecode(widget.data)['imageUrl']),
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 30,top: 20),
          //     child: Icon(Icons.bookmark,color: Colors.grey[400],size: 40,),
          //   ),
          // ],),

          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
            child: Text(jsonDecode(widget.data)['title'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800),),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
            child: Text(jsonDecode(widget.data)['content'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color: Colors.grey[500]),),
          ),

          Container(
            height: 100,
            child: AdWidget(
              ad: addmobHelper.getBannerAdd()!,
            )
          ),

          Container(
            height: 60,
            child: AdWidget(
              ad: addmobHelper.getBannerAdd()!,
            )
          ),
          Container(
            height: 60,
            child: AdWidget(
              ad: addmobHelper.getBannerAdd()!,
            )
          ),
          Container(
            height: 60,
            child: AdWidget(
              ad: addmobHelper.getBannerAdd()!,
            )
          ),
        ],
      ),
      )
    );
  }
}
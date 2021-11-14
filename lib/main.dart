// ignore_for_file: library_prefixes

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newzer/pages/home.dart';
var box;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isdark = false;

  void gg()async{
    setState(() {
      isdark=!isdark;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: isdark?Brightness.dark:Brightness.light
        
      ),
      
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                        "NEWZER",
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
              isdark?InkWell(onTap: (){gg();}, child: Icon(Icons.light_mode)):InkWell(onTap: (){gg();}, child: Icon(Icons.dark_mode))
            ],
          ),
          backgroundColor: isdark?Colors.grey[800]:Color.fromRGBO(108, 93, 211,1),
        ),
        body: HomePage(),
      )
    );
  }
}


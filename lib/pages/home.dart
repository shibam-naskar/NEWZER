import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:newzer/main.dart';
import 'package:newzer/pages/newsDetail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness;
  var color = Colors.blue;
  var filterList = [
    "all",
    "national",
    "business",
    "sports",
    "world",
    "politics",
    "technology",
    "startup",
    "entertainment",
    "miscellaneous",
    "hatke",
    "science",
    "automobile"
  ];
  var icon = "10d";
  double temperature = 0.0;
  double wind = 0;
  var area = "INDIA";
  var description = "getting description";
  var catagory = "all";
  var newzes = [];

  @override
  void initState() {
    askPermissions();
    getNews();
    super.initState();
    print(brightness);
  }

  void askPermissions() async {
    var status = await Permission.location.status;
    print(status);
    if (status.isGranted) {
      getCordinates();
    } else {
      var locationStatus = await Permission.location.request();
      if (locationStatus.isGranted) {
        getCordinates();
      }
    }
  }

  void getCordinates() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest);
    print(position);
    getAddress(position.latitude, position.longitude);
    getWeather(position.latitude, position.longitude);
  }

  void getAddress(lat, long) async {
    final coordinates = new Coordinates(lat, long);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    print(addresses.first.locality);
    setState(() {
      area = addresses.first.locality;
    });
  }

  void getWeather(lat, long) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=&units=metric');
    var response = await http.get(url);
    print(response.body);
    print(jsonDecode(response.body)['weather'][0]["icon"]);
    setState(() {
      icon = jsonDecode(response.body)['weather'][0]["icon"];
      description = jsonDecode(response.body)['weather'][0]["description"];
      temperature = jsonDecode(response.body)['main']["temp"];
      wind = jsonDecode(response.body)['wind']["speed"];
    });
  }

  void getNews() async {
    var url =
        Uri.parse('https://inshortsapi.vercel.app/news?category=$catagory');
    var response = await http.get(url);
    setState(() {
      newzes = jsonDecode(response.body)['data'];
    });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          
          // Padding(
          //   padding: const EdgeInsets.only(left: 10, right: 10),
          //   child: Row(
          //     children: [
          //       InkWell(
          //         // onTap: (){
          //         //   MyApp.changeTheme();
          //         // },
          //         child: Image.asset(
          //           "./lib/assets/logo.png",
          //           width: 40,
          //         ),
          //       ),
          //       Spacer(),
          //       Padding(
          //         padding: const EdgeInsets.only(right: 20),
          //         child: Text("${catagory.toUpperCase()} Newzes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.blue),),
          //       )
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 15,
          ),

          ///time data and weather field................................

          Container(
            width: MediaQuery.of(context).size.width * 0.97,
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(
                            color: Colors.white,
                            blurRadius: 20.0,
                          ),],
                color: Color.fromRGBO(108, 93, 211,1), borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        area,
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 25,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        DateTime.now().day.toString() +
                            "/" +
                            DateTime.now().month.toString() +
                            "/" +
                            DateTime.now().year.toString(),
                        style: TextStyle(
                            color: Colors.white60,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text(
                            temperature.toString(),
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "Degree C",
                            style: TextStyle(color: Colors.white60),
                          ),
                          Text(
                            "Wind Speed $wind",
                            style: TextStyle(color: Colors.white60),
                          )
                        ],
                      )),
                      Image.network(
                        "https://openweathermap.org/img/wn/$icon@4x.png",
                        width: 120,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //catagories ................................................
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterList.length,
              itemBuilder: (context, ind) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      if (catagory != filterList[ind]) {
                        newzes = [];
                        catagory = filterList[ind];

                        getNews();
                      }
                    });
                    print(filterList[ind]);
                  },
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            right: 20, left: 20, top: 20, bottom: 10),
                        child: Text(filterList[ind],
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold))),
                  ),
                );
              },
            ),
          ),

          //Reminder wii workon it tomorrow morning....................................................................

          Container(
            child: Expanded(
                child: newzes.length == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: newzes.length,
                        itemBuilder: (context, ind) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NewsDetailsPage(data: jsonEncode(newzes[ind]))));
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        newzes[ind]['imageUrl'],
                                        width: 150,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.50,
                                          child: Text(newzes[ind]['title'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.grey[700])),
                                        ),
                          
                                        SizedBox(height: 10,),
                          
                                        Container(
                                          width: MediaQuery.of(context).size.width *
                                                  0.50,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(newzes[ind]['author'],style: TextStyle(fontSize: 12),)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          )
        ],
      ),
    );
  }
}

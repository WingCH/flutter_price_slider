import 'package:flutter/material.dart';
import 'package:flutter_price_slider/flutter_price_slider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Flutter price slider"),
        ),
        body: Center(

          child: FlutterPriceSlider(
            selectedBoxColor: Color(0xFF2ebd85),
            unselectedBoxColor:  Color(0xFF29313c),
            selectedTextColor: Color(0xFFeaecef),
            unselectedTextColor: Color(0XFF999999),
            onSelectedProportion: (proportion) {
              print(proportion);
            },
          ),
        ),
      ),
    );
  }
}



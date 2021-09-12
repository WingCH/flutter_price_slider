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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Color(0xFFfffffe),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Light mode",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(height: 10),
                    FlutterPriceSlider(
                      selectedBoxColor: Color(0xFF2ebd85),
                      unselectedBoxColor: Color(0xFFf9f9f9),
                      selectedTextColor: Color(0xFF000000),
                      unselectedTextColor: Color(0XFF7d8896),
                      onSelected: (proportion) {
                        print(proportion);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFF20262f),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dark mode",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    SizedBox(height: 10),
                    FlutterPriceSlider(
                      selectedBoxColor: Color(0xFF2dbd85),
                      unselectedBoxColor: Color(0xFF29303d),
                      selectedTextColor: Color(0xFFf1f4f6),
                      unselectedTextColor: Color(0XFF7f8997),
                      onSelected: (proportion) {
                        print(proportion);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

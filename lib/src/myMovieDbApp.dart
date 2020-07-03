import 'package:flutter/material.dart';
import 'package:themoviedb/src/ui/DetailsScreen.dart';
import 'package:themoviedb/src/ui/homeScreen.dart';
import 'package:themoviedb/src/utils/routes.dart';

class MyTheMovieDbApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        Routes.homeRoute: (BuildContext context) => HomeScreen(),
        Routes.detail: (BuildContext context) => DetailsScreen(),
      }
    );
  }
}
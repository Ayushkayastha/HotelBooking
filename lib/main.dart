import 'package:flutter/material.dart';
import 'package:hotel_app/bottom_nav_bar.dart';
import 'package:hotel_app/backend/API/HotelDetails.dart';
import 'package:hotel_app/features/datas.dart';
import 'package:provider/provider.dart'; // Import the HotelDetails class


void main() {
  runApp(
      ChangeNotifierProvider(
        create: (Builder)=>Datas(),
        child:  MyApp(),
      )

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 81, 212, 194)),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color:Color.fromARGB(255, 81, 212, 194),
          ),
        ),
      ),
      home:  Bottomnavbar(),
    );
  }
}


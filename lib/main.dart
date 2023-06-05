import 'package:flutter/material.dart';
import 'package:seat_finder/views/homepage/UI/home_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seat Finder',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Colors.redAccent),
      ),
      home: const HomeScreen(seatCount: 20),
    );
  }
}

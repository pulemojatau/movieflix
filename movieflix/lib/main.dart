import 'package:flutter/material.dart';
import 'package:movieflix/pages/login.dart';
import 'package:movieflix/pages/movieDetails.dart';

import 'utils/hexcolor.dart';
import 'pages/home.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(




      home:  HomePage(),
      debugShowCheckedModeBanner: false, // Disables the debug banner
    );
  }
}







import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflix/pages/watchlist.dart';

import '../pages/home.dart';



class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
        
          IconButton(
            onPressed: () async {
               //Get the email of the currently authenticated user

              // Navigate to the ChatPage and pass the email as an argument
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => HomePage(

                   ),
                 ),
               );
            },
            icon: const Icon(Icons.home),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () async {

              // Navigate to the ChatPage and pass the email as an argument
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => Watchlist(

                   ),
                 ),
               );
            },
            icon: const Icon(Icons.watch_later),
            color: Colors.black,
          ),


          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Notifications(
              //
              //     ),
              //   ),
              // );
            },
            icon: const Icon(Icons.category),
            color: Colors.black,
          ),

        ],
      ),
    );
  }
}

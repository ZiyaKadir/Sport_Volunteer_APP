// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBar.dart';
import 'NavBarSignedUp.dart';
import 'ClassStructures/event.dart';
import 'ClassStructures/volunteer.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Certificate extends StatelessWidget {
   late Box<Volunteer> _myBox;
 

  final Uri _url = Uri.parse('https://sporgonulluleri.com/');
  Certificate(){
          _myBox = Hive.box<Volunteer>('my_box');

  }
  _launchurl() async {
    if (await launchUrl(_url)) {
      print("can not open");
    }
  }

  @override
  Widget build(BuildContext context) {
     bool isUserSignedUp = _myBox.isNotEmpty;
    Widget drawer = isUserSignedUp ? NavBarSignedUp() : NavBar();
    return Scaffold(
      appBar: const My_Appbar(),
      drawer: drawer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Sertifikalara alttaki butondan ulaşabilirsiniz",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _launchurl,
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Container(
                width: 70,
                height: 70,
                child: Center(
                  child: Icon(
                    Icons.article_outlined,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: My_bottom_bar(),
    );
  }
}

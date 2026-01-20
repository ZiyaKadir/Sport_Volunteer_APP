import 'package:flutter/material.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'Information.dart';
import 'NavBar.dart';
import 'ClassStructures/volunteer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'NavBarSignedUp.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  var _myBox = Hive.box<Volunteer>('my_box');


  @override
  Widget build(BuildContext context) {
    bool isUserSignedUp = _myBox.isNotEmpty;
    Widget drawer = isUserSignedUp ? NavBarSignedUp() : NavBar();
    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 203, 203, 0.984),
      appBar: My_Appbar(),
      drawer: drawer,
      body: InformationForm(),
      bottomNavigationBar: My_bottom_bar(),
    );
  }
}

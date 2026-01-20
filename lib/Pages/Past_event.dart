import 'package:flutter/material.dart';
import 'DetailScreen2.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBar.dart';
import 'dart:typed_data';
import 'ClassStructures/volunteer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'NavBarSignedUp.dart';
import 'ClassStructures/event.dart';
import 'ClassStructures/volunteer.dart';
import 'dart:convert';

class Past_event extends StatefulWidget {
  @override
  _Pastevent_pageState createState() => _Pastevent_pageState();
}

class _Pastevent_pageState extends State<Past_event> {
  double screenWidth = 0;
  double screenHeight = 0;
  Volunteer? signedVolunteer;
  late Box<Volunteer> _myBox;
  Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }

  List<Event> events = [];
  List<Event> data = [];
  List<Widget> dataContainers = [];
  int length = 0;
  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<Volunteer>('my_box');
    fetchData();
  }

  Future<void> fetchData() async {
    final Uri uri = Uri.parse('http://' + myip + '/mobilePastEvents');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      for (var json in responseData) {
        Event event = Event(
          idevent: json['idevent'],
          eventName: json['eventName'],
          eventDescription: json['eventDescription'],
          eventStatus: json['eventStatus'],
          eventStartingDate: json['eventStartingDate'],
          eventFinishDate: json['eventFinishDate'],
          eventLocation: json['eventLocation'],
          eventPhoto: json['eventPhoto'].toString(),
        );
        events.add(event);
      }

      setState(() {
        data = events;
        dataContainers = events.map((Event current) {
          var resim;
          String base64Image = current.eventPhoto;
          resim = base64StringToUint8List(base64Image);

          return Container(
            height: 200,
            width: 375,
            margin: EdgeInsets.only(
              bottom: screenWidth / 20,
            ),
            child: Hero(
              tag: current.idevent,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 200,
                width: 375,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    resim,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        }).toList();
      });
    } else {
      setState(() {
        data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUserSignedUp = _myBox.isNotEmpty;
    Widget drawer = isUserSignedUp ? NavBarSignedUp() : NavBar();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: My_Appbar(),
      bottomNavigationBar: My_bottom_bar(),
      drawer: drawer,
      body: ListView.builder(
        itemCount: dataContainers.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Tıklanan etkinliğin detay sayfasına geçiş yap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen2(event: events[index]),
                ),
              );
            },
            child: dataContainers[index],
          );
        },
      ),
    );
  }
}

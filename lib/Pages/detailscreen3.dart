import 'package:flutter/material.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBarSignedUp.dart';
import 'detailscreen3.dart';
import 'ClassStructures/event.dart';
import 'ClassStructures/eventApplicant.dart';
import 'ClassStructures/volunteer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'NavBar.dart';
import 'package:hive_flutter/hive_flutter.dart';
class DetailScreen3 extends StatelessWidget {
  const DetailScreen3({Key? key, required this.applicants}) : super(key: key);
  final Applicant applicants;
    Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }
  @override
  Widget build(BuildContext context) {
    var resim;
        String base64Image = applicants.eventPhoto;
        resim = base64StringToUint8List(base64Image);
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(
          31, 40, 39, 39), // Set the background color to black
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Handle the tap action here, if needed
                },
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 400.0,
                  height: 200.0,
                  color: Colors.blue,
                  child: Image.memory(
                        resim,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                applicants.eventName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
               Container(
                 child: Text(
                  '    '+applicants.eventDescription,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                 ),
                 margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
               ),
              Container(
                width:375,
                child: Text(
                  'Başlangıç Tarihi:'+applicants.eventStartingDate,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
              
              Container(
                width:375,
                child: Text(
                  'Bitiş Tarihi:'+applicants.eventFinishDate,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
               Container(
                 width:375,
                 child: Text(
                  
                  'Address:'+applicants.eventLocation,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                               ),
               ),
             
            ],
          ),
        ),
      ),
    );
  }
}

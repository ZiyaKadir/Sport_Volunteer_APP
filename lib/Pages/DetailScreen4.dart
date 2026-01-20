
import 'package:flutter/material.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBarSignedUp.dart';
import 'ClassStructures/event.dart';
import 'ClassStructures/eventApplicant.dart';
import 'ClassStructures/volunteer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'NavBar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'ClassStructures/education.dart';
class DetailScreen4 extends StatelessWidget {
  const DetailScreen4({Key? key, required this.education}) : super(key: key);
  final Education education;
    Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }
  @override
  Widget build(BuildContext context) {
    var resim;
    
    String base64Image = education.educationPhoto;
    resim = base64StringToUint8List(base64Image);
    Future<bool> ApplytoEducation() async {
      myVolunteer = get_volunteer();
     
      final url = 'http://' + myip + '/mobileEducationApply';

      //int? id = volunteer.idvolunteer;
      if (myVolunteer.volunteerEposta == "") {

        Navigator.of(context).pushNamed('/Sign_in_page');
      } else if (myVolunteer.volunteerFirstName == "" ||
          myVolunteer.volunteerLastName == "" ||
          myVolunteer.volunteerPhoneNo == "" ||
          myVolunteer.volunteerBirthday == "" ||
          myVolunteer.volunteerAddress == "" ||
          myVolunteer.volunteerAddress == "" ||
          myVolunteer.volunteerGender == "") {
      
        Navigator.of(context).pushNamed('/settings_page');
      } else {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'ideducation': education.ideducation.toString(),
            'idvolunteer': myVolunteer.idvolunteer.toString(),
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
      
          String message;
          if(response.body.toString()=="0"){
            message="Başvuru başarılı!";
          }else{
            message="Başvuru daha önce yapılmış!";
          }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.orange.shade300,
                  content: Text(
                    message,
                      style: TextStyle(fontSize: 24),
                ),
              ),
            ); 
        } else {
          return false;
        }
      }
      return true;
    }
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
                education.educationName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set text color to white
                ),
              ),
               Container(
                 child: Text(
                  '    '+education.educationDescription,
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
                  'Başlangıç Tarihi:'+education.educationStartingDate,
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
                  'Bitiş Tarihi:'+education.educationFinishDate,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                ),
              ),
               Container(
                 width:375,
                 child: Text(
                  
                  'Address:'+education.educationLocation,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    
                    fontSize: 18.0,
                    color: Colors.white, // Set text color to white
                  ),
                               ),
               ),
              Container(
              width: 100,
              child: ElevatedButton(
              onPressed: () {
                ApplytoEducation();
                //apply button calıştığı yer kendi yazdığın event id ile ve kullancı classındaki  username ile bunu post işlemi
                // yaparak database de evente kaydet
              },
              child: Text('Başvur', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 228, 19),
                fixedSize: Size(10, 5),
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

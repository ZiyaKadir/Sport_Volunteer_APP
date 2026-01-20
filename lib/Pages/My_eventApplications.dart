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
import 'My_educationApplicants.dart';
class My_eventApplications extends StatefulWidget {
  @override
  _My_applications_pageState createState() => _My_applications_pageState();
}

class _My_applications_pageState extends State<My_eventApplications> {
    double screenWidth = 0;
    double screenHeight = 0;
    Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }
   late Box<Volunteer> _myBox;
  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<Volunteer>('my_box');
    fetchData();
  }
  List<Applicant> applicants = [];
  List<Applicant> data = [];
  List<Widget> dataContainers = [];
  Future<void> fetchData() async {
     final url = 'http://' + myip + '/mobileEventApplicants';
    Volunteer volunteer = get_volunteer();
    int? id = volunteer.idvolunteer;
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData == null) {
      } else {
        for (var json in responseData) {
          Applicant myApplicant = Applicant(
          applicantsStatus: json['applicantsStatus'],
          idevent: json['idevent'],
          eventName: json['eventName'],
          eventDescription: json['eventDescription'],
          eventStatus: json['eventStatus'],
          eventStartingDate: json['eventStartingDate'],
          eventFinishDate: json['eventFinishDate'],
          eventLocation: json['eventLocation'].toString(),
          eventPhoto: json['eventPhoto'].toString(),
          );
          applicants.add(myApplicant);
        }
        setState(() {
        dataContainers = applicants.map((Applicant current) {
        var resim;
        String base64Image = current.eventPhoto;
        resim = base64StringToUint8List(base64Image);
        return Container(
          margin: EdgeInsets.all(10),
          child: Hero(
            tag: current.eventName,
            child: Row(
              children: [
                  Container(
                  //
                  height: 160,
                  width: 160,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      resim,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
             
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                
                      current.eventName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20), // Add spacing between texts
                    Row(
                      children: [
                        Text('Başlangıç Tarihi:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 20),
                        Text(current.eventStartingDate),
                        SizedBox(height: 20), // A
                      ]
                    ),
                      Row(
                      children: [
                        Text('Bitiş Tarihi:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(height: 20),
                        Text(current.eventFinishDate),
                        SizedBox(height: 20), // A
                      ]
                    ),
                    if (current.applicantsStatus == 0)
                      Text("Onay Bekleniyor", style: TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                    if (current.applicantsStatus == 1)
                      Text("Onaylandı", style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 20)),
                    if (current.applicantsStatus == 2)
                      Text("Reddedildi", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(height: 20),
                
                  ],
                ),
              ),
            ),
            ]
            ),
          ),
        );
        }).toList();
      });
      } 
    }
  }


  Widget build(BuildContext context) {
    bool isUserSignedUp = _myBox.isNotEmpty;
    Widget drawer = isUserSignedUp ? NavBarSignedUp() : NavBar();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: My_Appbar(),
      bottomNavigationBar: My_bottom_bar(),
      drawer: drawer,
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    //apply button calıştığı yer kendi yazdığın event id ile ve kullancı classındaki  username ile bunu post işlemi
                    // yaparak database de evente kaydet
                  },
                  child: Text('Etkinlikler', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 4, 63, 9),
                    fixedSize: Size(200, 5),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => My_educationApplications()),
              );
                  
              },
                child: Text('Eğitimler', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 4, 63, 99),
                  fixedSize: Size(200, 5),

              ),
            ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dataContainers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Tıklanan etkinliğin detay sayfasına geçiş yap
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen3(applicants: applicants[index]),
                        ),
                      );
                    },
                    child: dataContainers[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: My_Appbar(),
      drawer: NavBarSignedUp(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(), // Use the _buildImage function
            SizedBox(width: 16), // Add spacing between image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Etkinlik Adı',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20), // Add spacing between texts
                  Text('Başlangıç Tarihi: 01.01.2023'),
                  SizedBox(height: 20),
                  Text('Bitiş Tarihi: 03.01.2023'),
                  SizedBox(height: 20), // Add spacing between texts
                  Container(
                    color: Colors.red, // Set background color to red
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Onay Bekleniyor',
                      style: TextStyle(
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: My_bottom_bar(),
    );
  }
}
*/
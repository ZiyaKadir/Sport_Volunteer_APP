import 'package:flutter/material.dart';
import 'ClassStructures/event.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'ClassStructures/volunteer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'Services/notifi_service.dart';
class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> ApplytoEvent() async {
      myVolunteer = get_volunteer();

      final url = 'http://' + myip + '/mobileEventApply';

      //int? id = volunteer.idvolunteer;
      if (myVolunteer.volunteerEposta == "") {
        debugPrint("Giriş Yapılmamış");
        Navigator.of(context).pushNamed('/Sign_in_page');
      } else if (myVolunteer.volunteerFirstName == "" ||
          myVolunteer.volunteerLastName == "" ||
          myVolunteer.volunteerPhoneNo == "" ||
          myVolunteer.volunteerBirthday == "" ||
          myVolunteer.volunteerAddress == "" ||
          myVolunteer.volunteerAddress == "" ||
          myVolunteer.volunteerGender == "") {
        debugPrint("Hesap güncellenmemiş!");
        Navigator.of(context).pushNamed('/settings_page');
      } else {
        final response = await http.post(
          Uri.parse(url),
          body: {
            'idevent': widget.event.idevent.toString(),
            'idvolunteer': myVolunteer.idvolunteer.toString(),
          },
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          debugPrint("body"+response.body);

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
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
              content: Text('Başvuru sırasında bir hata oluştu.'),
              duration: Duration(seconds: 2),
              ),
            );
        }
      }
      return true;
    }

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var resim;
    String base64Image = widget.event.eventPhoto;
    resim = base64StringToUint8List(base64Image);

    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 40, 39, 39),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: widget.event.eventName,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                child: SizedBox(
                  height: screenHeight / 2.2,
                  width: screenWidth,
                  child: Image.memory(
                    resim,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              widget.event.eventName,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Text(
              widget.event.eventDescription,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(31, 40, 39, 39),
        height: 70,
        child: Center(
          child: Container(
            width: 100,
            child: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () {
                    ApplytoEvent();
                
                    //apply button calıştığı yer kendi yazdığın event id ile ve kullancı classındaki  username ile bunu post işlemi
                    // yaparak database de evente kaydet
                  },
                  child: Text('Başvur', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 228, 19),
                    fixedSize: Size(10, 5),
                  ),
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

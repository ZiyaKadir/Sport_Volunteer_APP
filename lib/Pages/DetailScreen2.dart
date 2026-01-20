import 'package:flutter/material.dart';
import 'ClassStructures/event.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'ClassStructures/volunteer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class DetailScreen2 extends StatefulWidget {
  const DetailScreen2({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  State<DetailScreen2> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen2> {
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
          debugPrint("Başvuru başarılı!");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Başvuru başarılı!'),
              duration: Duration(seconds: 2),
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
          ),
        ),
      ),
    );
  }
}

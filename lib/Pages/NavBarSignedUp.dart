import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaiton_pages/Pages/ClassStructures/volunteer.dart';
import 'HakkimizdaPage.dart';
import 'AkademiPage.dart';
import 'My_eventApplications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ClassStructures/volunteer.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:typed_data';
class NavBarSignedUp extends StatelessWidget {
  final Uri _url = Uri.parse('https://www.instagram.com/sporgonulluleri');
  final Uri _twitterUrl = Uri.parse('https://twitter.com/sporgonulluler');
  final Uri _facebookUrl =
      Uri.parse('https://www.facebook.com/turkiyesporgonulluleri/');
  _launchurl() async {
    if (await launchUrl(_url)) {
      print("can not open");
    }
  }

  _launchTwitterUrl() async {
    if (await launchUrl(_twitterUrl)) {
      print("can not open");
    }
  }

  _launchYouTubeUrl() async {
    if (await launchUrl(_facebookUrl)) {
      print("can not open");
    }
  }
  Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }
  @override
  Widget build(BuildContext context) {
    Volunteer zaor = get_volunteer();
    var resim = null;
    String base64Image = zaor.volunteerPhoto;
   if(zaor.volunteerPhoto.toString()=="null"){
          base64Image="";
        }else if(zaor.volunteerPhoto.toString()==""){
          base64Image="";
          }
        else{
            resim = base64StringToUint8List(base64Image);
        }
    return Drawer(
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(7, 67, 49, 1),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hoş Geldiniz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                      Container(
                        margin: EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          // radius: 50,
                          child: resim != null
                          ? Image.memory(
                          resim,
                          fit: BoxFit.cover,
                          )
                          : Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Colors.white,
                            ),

                        ),
                      ),
                    Text(
                      "${zaor.volunteerName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: const Text('Akademi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AkademiPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Hakkımızda'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HakkimizdaPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Başvurularım'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => My_eventApplications()),
              );
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');

                    deleteVolunteer();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const ListTile(
                    title: Text(
                      'Çıkış Yap',
                      style: TextStyle(
                        color: Color.fromRGBO(7, 67, 49, 1),
                        fontSize: 18,
                      ),
                    ),
                    leading: Icon(
                      Icons.login,
                      color: Color.fromRGBO(7, 67, 49, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      SignInButton(
                        button: Button.Instagram,
                        mini: true,
                        onPressed: _launchurl,
                        splashColor: Colors.red,
                      ),
                      const SizedBox(width: 16),
                      SignInButton(
                        button: Button.Twitter,
                        mini: true,
                        onPressed: _launchTwitterUrl,
                        splashColor: Colors.blue,
                      ),
                      const SizedBox(width: 16),
                      SignInButton(
                        button: Button.Facebook,
                        mini: true,
                        onPressed: _launchYouTubeUrl,
                        splashColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

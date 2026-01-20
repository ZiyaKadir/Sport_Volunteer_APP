import 'package:custom_signin_buttons/button_data.dart';
import 'package:custom_signin_buttons/button_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaiton_pages/Pages/Users/SignOut.dart';
import 'package:flutter_applicaiton_pages/Pages/Users/User.dart';
import 'HakkimizdaPage.dart';
import 'AkademiPage.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          User(),
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Sign_out(),
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

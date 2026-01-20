import 'package:flutter/material.dart';
import 'package:flutter_applicaiton_pages/Pages/ClassStructures/volunteer.dart';

class My_bottom_bar extends StatelessWidget {
  const My_bottom_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color.fromRGBO(97, 173, 151, 0.667),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            color: Colors.white,
            onPressed: () {
              // boyle kullanmak daha mantikli gibi
              //Navigator.of(context).pushNamed("/Home_page");
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.of(context).pushNamed('/');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            color: Colors.white,
            onPressed: () {
              // push replacement stack yeri degisir bu kullanilabilir stack surekli yer tutmus olmaz
              if (ModalRoute.of(context)?.settings.name != '/past_event_page') {
                Navigator.of(context).pushNamed('/past_event_page');
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.article_outlined),
            color: Colors.white,
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name !=
                  '/certificate_page') {
                Navigator.of(context).pushNamed('/certificate_page');
              }
            },
          ),
          IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                if (myBox.isNotEmpty) {
                  if (ModalRoute.of(context)?.settings.name !=
                      '/settings_page') {
                    Navigator.of(context).pushNamed('/settings_page');
                  }
                } else {
                  if (ModalRoute.of(context)?.settings.name !=
                      '/Sign_in_page') {
                    Navigator.of(context).pushNamed('/Sign_in_page');
                  }
                }
              })
        ],
      ),
    );
  }
}

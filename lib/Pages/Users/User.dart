import 'package:flutter/material.dart';
import '../ClassStructures/volunteer.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  bool isSignedIn = myBox.isNotEmpty; // Add a variable to track sign-in status

  @override
  Widget build(BuildContext context) {
    return isSignedIn
        ? _buildSignedInContainer() // Show a different container when signed in
        : _buildInitialContainer();
  }

  Widget _buildInitialContainer() {
    return Container(
      color: Color.fromRGBO(7, 67, 49, 1),
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/Sign_in_page') {
                Navigator.of(context).pushNamed('/Sign_in_page');
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: const ListTile(
              title: Text(
                'Giriş Yap',
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
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (ModalRoute.of(context)?.settings.name != '/Sign_up_page') {
                Navigator.of(context).pushNamed('/Sign_up_page');
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
            ),
            child: const ListTile(
              title: Text(
                'Kayıt Ol',
                style: TextStyle(
                  color: Color.fromRGBO(7, 67, 49, 1),
                  fontSize: 18,
                ),
              ),
              leading: Icon(
                Icons.person_add,
                color: Color.fromRGBO(7, 67, 49, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignedInContainer() {
    Volunteer zaor = get_volunteer();
    // Replace this with the container you want to show when signed in
    return Container(
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
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/logo.png'),
                  backgroundColor: Colors.black,
                  radius: 30,
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
    );
  }
}

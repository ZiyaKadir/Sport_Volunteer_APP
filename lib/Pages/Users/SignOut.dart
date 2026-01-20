import 'package:flutter/material.dart';
import '../ClassStructures/volunteer.dart';

class Sign_out extends StatefulWidget {
  @override
  _Sign_outState createState() => _Sign_outState();
}

class _Sign_outState extends State<Sign_out> {
  bool isSignedIn = myBox.isNotEmpty; // Add a variable to track sign-in status

  @override
  Widget build(BuildContext context) {
    return isSignedIn
        ? _buildInitialContainer() // Show a different container when signed in
        : _buildSignedInContainer();
  }

  Widget _buildInitialContainer() {
    return Container(
      child: ElevatedButton(
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
            'Çıkış yap',
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
    );
  }

  Widget _buildSignedInContainer() {
    // Replace this with the container you want to show when signed in
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_applicaiton_pages/Pages/ClassStructures/volunteer.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Verification_forget extends StatelessWidget {
  //const Verification({super.key});
  final TextEditingController _verificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Navigator.of(context).pushNamed('/reset_page');
    String message="";
    final _formKey = GlobalKey<FormState>();
    Future<void> controlVerification() async {
      final url = 'http://'+myip+'/mobileforgetVerification';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'code': _verificationController.text.toString(),
        },
      );

       if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if(responseData.toString()=="1"){
            Navigator.of(context).pushNamed('/reset_page');
          }else{
            message="Yanlış doğrulama kodu!";
            ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange.shade300,
                            content: Text(
                              message,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
          }
          
       }else{
        
        
       }
    }

    final Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>? ??
            {};

    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 203, 203, 5),
      appBar: My_Appbar(),
      drawer: NavBar(),
      body: ListView(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50.0),
              child: const Text(
                'Verification',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              // height: 200,
              // width: 200,
              // decoration: BoxDecoration(color: Colors.amber),
            ),
          ),
          Center(
            child: Container(
              // margin: EdgeInsets.only(top: 50.0),
              child: const Text(
                'We will send you One Time Code on your e-mail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              // height: 200,
              // width: 200,
              // decoration: BoxDecoration(color: Colors.amber),
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              height: 60,
              width: 350,
              child: TextFormField(
                controller: _verificationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Verification Code',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  focusColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.white), // Hint text color
                  filled: true,
                  fillColor: Color.fromRGBO(120, 158, 137, 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black), // Border color when enabled
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.black), // Border color when focused
                  ),
                ),
                style: TextStyle(color: Colors.white), // Text color
                onSaved: (deger) {
                  // volunteer_info.email = deger!;
                },
                validator: (deger) {},
              ),
            ),
          ),
          ////////////////////////////////////////////////////////
          Container(
            margin: EdgeInsets.only(top: 50.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  controlVerification();
                  
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(23, 231, 84, 1.0), // Corrected opacity value
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                    Size(200, 50), // Adjust the width and height as needed
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: My_bottom_bar(),
    );
  }
}

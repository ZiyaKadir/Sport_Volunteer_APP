import 'package:flutter/material.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'ClassStructures/volunteer.dart';
import 'NavBar.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'ClassStructures/volunteer.dart';

class reset_password extends StatelessWidget {
  const reset_password({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(203, 203, 203, 5),
      appBar: My_Appbar(),
      drawer: NavBar(),
      body: SignInBody(),
      bottomNavigationBar: My_bottom_bar(),
    );
  }
}

class SignInBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _againPasswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    String message="";
    Future<void> newPassword() async {
      final url = 'http://'+myip+'/mobileNewPassword';
        if(_passwordController.text.toString()==_againPasswordController.text.toString()){
            final response = await http.post(
              Uri.parse(url),
              body: {
                'eposta':verificationEposta.toString(),
                'password': _passwordController.text.toString(),
              },
            );
            if (response.statusCode == 200) {
                final responseData = json.decode(response.body);
                if(responseData.toString()=="1"){
                  Navigator.of(context).pushNamed('/Sign_in_page');
                }
            }else{

            }

        }else{

          message="Şifreler uyuşmuyor!";
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

      
        



     }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(top: 65.0, left: 15),
                child: const Text(
                  'New Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // height: 200,
                // width: 200,
                // decoration: BoxDecoration(color: Colors.amber),
              ),
              SizedBox(height: 10.0),

              Center(
                child: Container(
                  height: 60,
                  // width: 350,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your new password',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromRGBO(120, 158, 137, 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true, // For password fields
                    onSaved: (deger) {
                      myVolunteer.volunteerPassword = deger.toString();
                    },
                    validator: (deger) {
                      if (deger!.isEmpty) {
                        return 'Şifre boş olamaz';
                      } else
                        return null;
                    },
                  ),
                ),
              ),

              // Add some space between password and confirmation fields

              // Confirm Password input
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 15),
                child: const Text(
                  'New password again',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // height: 200,
                // width: 200,
                // decoration: BoxDecoration(color: Colors.amber),
              ),
              SizedBox(height: 16.0),

              // Confirm Password input

              Center(
                child: Container(
                  height: 60,
                  child: TextFormField(
                    controller: _againPasswordController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm your password',
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromRGBO(120, 158, 137, 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    //controller: _confirmPasswordController,
                    validator: (deger) {
                      if (deger!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      if (deger.toString() !=
                          _passwordController.text.toString()) {
                        return 'Şifreler uyuşmuyor !';
                      } else
                        return null;
                    },
                  ),
                ),
              ),

              SizedBox(height: 16.0),

              // Forgot password link

              SizedBox(height: 16.0),

              // Sign In button
              Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      newPassword();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(
                            23, 231, 84, 1.0), // Corrected opacity value
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(200, 60), // Adjust the width and height as needed
                      ),
                    ),
                    child: const Text(
                      'Güncelle',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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

import 'package:flutter/material.dart';
import 'My_Appbar.dart';
import 'My_bottombar.dart';
import 'NavBar.dart';
import 'package:email_validator/email_validator.dart';

import 'package:http/http.dart' as http;
import 'ClassStructures/volunteer.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';


class Sign_in extends StatelessWidget {
  const Sign_in({super.key});


  
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
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   
  Future<bool> controlUserData() async {
  final url = 'http://'+myip+'/mobileSignIn';
  final response = await http.post(
    Uri.parse(url),
    body: {
      'email': _emailController.text.toString(),
      'password': _passwordController.text.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);

    if (responseData == null) {
      return false;
    } else {
      for (var json in responseData) {
        myVolunteer =Volunteer(
          idvolunteer: json['idvolunteer'],
          volunteerName: json['volunteerName'],
          volunteerFirstName: json['volunteerFirstName'],
          volunteerLastName: json['volunteerLastName'],
          volunteerPassword: json['volunteerPassword'],
          volunteerEposta: json['volunteerEposta'],
          volunteerPhoneNo: json['volunteerPhoneNo'],
          volunteerBirthday: json['volunteerBirthday'].toString(),
          volunteerGender: json['volunteerGender'].toString(),
          volunteerAddress: json['volunteerAddress'].toString(),
          volunteerPhoto: json['volunteerPhoto'].toString(),
          volunteerJob: json['volunteerJob'].toString(),
          volunteerLanguages: json['volunteerLanguages'].toString(),
          volunteerBlacklist: json['volunteerBlacklist'],
          
          );
          saveVolunteer(myVolunteer);
      }
      return true;
    }
  } else {

    return false;
  }
  }


  @override
  Widget build(BuildContext context) {
    Future<void> to_home() async {
          bool isSuccess = await controlUserData();
          String result;
          if (isSuccess) {
            result = "Giriş Başarılı!";
            Navigator.of(context).pushNamed('/');
            debugPrint("girdi");
            
          }
          else{
            result = "Giriş Başarısız!";
          }
          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange.shade300,
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
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
              // Email input field

              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: const Text(
                  'Email',
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

              Center(
                  child: Container(
                    height: 60,
                    child: TextFormField(
                      controller: _emailController,
                      //initialValue: 'emrealtunbilek@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Email giriniz',
                        focusColor: Colors.white,
                        hintStyle:
                            TextStyle(color: Colors.white), // Hint text color
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
                      validator: (deger) {
                        if (deger!.isEmpty) {
                          return 'email boş olamaz';
                        } else if (!EmailValidator.validate(deger)) {
                          return 'Geçerli mail giriniz';
                        } else
                          return null;
                      },
                    ),
                  ),
                ),

              //////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: const Text(
                  'Şifre',
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

              Center(
                  child: Container(
                    height: 60,
                    child: TextFormField(
                       controller: _passwordController,
                      //controller: _emailController,
                      decoration: const InputDecoration(
                        // labelText: 'Email',
                        hintText: 'Şifrenizi giriniz',
                        // Customize the colors
                        hintStyle:
                            TextStyle(color: Colors.white), // Hint text color
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
                      validator: (value) {},
                    ),
                  ),
                ),
              SizedBox(height: 16.0),

              // Forgot password link
              GestureDetector(
                onTap: () {
                  // Implement the logic for "Forgot Password?"
                  // For example, navigate to a password recovery page.
                  print("Forgot Password tapped");
                  Navigator.of(context).pushNamed('/forget_mail_page');
                },
                child: const Text(
                  'Şifremi unuttum',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              SizedBox(height: 16.0),

              // Sign In button
              Container(
                child: Center(
                  child: ElevatedButton(
                    
                    onPressed: () {
                      String result ;
                      bool _validate = _formKey.currentState!.validate();
                      if (_validate) {
                          to_home();
                        
                        
                        
                         
                        result="Giriş Başarılı!";
                        
                        _formKey.currentState!.save();

                        _formKey.currentState!.reset();
                      }
                      else{
                           result="Giriş Başarısız!";
                      }
                        
                    },
                    child: Text(
                      'Giriş yap',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(
                            23, 231, 84, 1.0), // Corrected opacity value
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(200, 60), // Adjust the width and height as needed
                      ),
                    ),
                  ),
                ),
              ),

              Row(
                children: [
                  const Text(
                    "Hesabınız var mı",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/Sign_up_page');
                    },
                    child: const Text(
                      'Kayıt olun',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  } //
}

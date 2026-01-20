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


class Sign_up extends StatelessWidget {
  const Sign_up({super.key});

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
 
    final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _againPasswordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {


  Future<void> sendUserData(String name, String email, String password) async {

       String result = "";
    
      final url = 'http://'+myip+'/mobileSignUp';
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': _emailController.text.toString(),
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if(responseData==1){
          debugPrint("Böyle bir e posta daha önce alınmış!");
          result = "Böyle bir e posta daha önce alınmış!";
          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange.shade300,
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
        }else{
          debugPrint("name"+name);
          debugPrint("eposta"+email);
          debugPrint("sifre"+password);
          myVolunteer.volunteerName=name;
          myVolunteer.volunteerEposta=email;
          myVolunteer.volunteerPassword=password;
          
          result = "Doğrulama kodunuz e mail yoluyla gönderildi!";
          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.orange.shade300,
                            content: Text(
                              result,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        );
          Navigator.of(context).pushNamed('/verification_page');
      }
     
      } else {
      // Hata durumu ile ilgili işlemleri burada yapabilirsiniz
        print('Hata oluştu: ${response.statusCode}');
      }
  }

    

  //////////////////////////////////////
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 15),
                child: const Text(
                  'İsim',
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
                  child: TextFormField(
                       controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'İsminizi Giriniz',
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
                        myVolunteer.volunteerName=deger.toString();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10.0, left: 15),
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
                      hintText: 'E-mail giriniz',
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
                        myVolunteer.volunteerEposta=deger.toString();
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
                margin: EdgeInsets.only(top: 10.0, left: 15),
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
              SizedBox(height: 10.0),

              Center(
                child: Container(
                  height: 60,
                  // width: 350,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Şiffrenizi girniz',
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
                        myVolunteer.volunteerPassword=deger.toString();
                    },
                    validator: (deger) {
                      if (deger!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }else
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
                  'Şifrenizi Tekrar',
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
                    controller:_againPasswordController,
                    decoration: const InputDecoration(
                      
                      hintText: 'Şifreniz tekrar giriniz',
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
                      if (deger.toString() != _passwordController.text.toString()) {
                        return 'Şifreler uyuşmuyor !';
                      } else
                        return null;
                    },
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
                      bool _validate = _formKey.currentState!.validate();
                      if (_validate) {
                        sendUserData(_nameController.text.toString(),_emailController.text.toString(),_passwordController.text.toString());
                        _formKey.currentState!.save();

                       
                        _formKey.currentState!.reset();
                      }
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
                      'Kayıt ol',
                      style: TextStyle(
                        color: Colors.white,
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
                      Navigator.of(context).pushNamed('/Sign_in_page');
                      print("Forgot Password tapped");
                    },
                    child: const Text(
                      'Giriş yap',
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
  }
}

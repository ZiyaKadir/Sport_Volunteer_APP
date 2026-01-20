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

class Forget_mail extends StatelessWidget {
  const Forget_mail({super.key});


  


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
  @override
  Widget build(BuildContext context) {
    String message="";
    String eposta="";
    final TextEditingController _epostaController = TextEditingController();
    //

    Future<void> confirmEposta() async {
      final url = 'http://' + myip + '/confirmEposta';
      

      if(_epostaController.text.toString()==""){
        message="E-posta boş olamaz!";
      }else{
        eposta=_epostaController.text.toString();
      }


      final response = await http.post(
        
        Uri.parse(url),
        body: {
          'eposta': eposta.toString(),
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if(responseData.toString()=="0"){
          message="E-posta Kayıtlı değil!";
        }else{
          verificationEposta=eposta;
          message="E-postanıza kod gönderildi!";
          Navigator.of(context).pushNamed('/verification_forget_page');
        }
        print('Veri başarıyla gönderildi');
      } else {
        // Hata durumu ile ilgili işlemleri burada yapabilirsiniz
        print('Hata oluştu: ${response.statusCode}');
      }




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

    




    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),

              Container(
                margin: EdgeInsets.only(top: 65.0, left: 15),
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
                    controller: _epostaController,
                    //initialValue: 'emrealtunbilek@gmail.com',
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      // labelText: 'Email',
                      hintText: 'Enter your email',
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
                      myVolunteer.volunteerEposta = deger.toString();
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

              // Forgot password link

              SizedBox(height: 16.0),

              // Sign In button
              Container(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      confirmEposta();
                     
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
                      'Kod Gönder',
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

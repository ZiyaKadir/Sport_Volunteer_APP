import 'package:flutter/material.dart';
import 'ClassStructures/User_info.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:email_validator/email_validator.dart';
import 'ClassStructures/volunteer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as IMG;
class InformationForm extends StatefulWidget {
  const InformationForm({Key? key}) : super(key: key);

  @override
  _InformationFormState createState() => _InformationFormState();
}

class _InformationFormState extends State<InformationForm> {
  File? _image;



  Future<void> _pickImageFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    File? croppedFile = await _cropImage(pickedFile.path);

    if (croppedFile != null) {
      // Resize the image
      File resizedImage = await resizeImage(croppedFile, 100, 100);

      setState(() {

        _image = resizedImage;
      });
    }
  }
}

Future<File> resizeImage(File imageFile, int width, int height) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  IMG.Image? img = IMG.decodeImage(Uint8List.fromList(imageBytes));
  IMG.Image? resized = IMG.copyResize(img!, width: width, height: height);
  Uint8List? resizedImgBytes = Uint8List.fromList(IMG.encodePng(resized));
  
  // Save the resized image to a new file
  Directory tempDir = await getTemporaryDirectory();
  File resizedFile = File('${tempDir.path}/resized_image.png');
  await resizedFile.writeAsBytes(resizedImgBytes);

  return resizedFile;
}

  Future<File?> _cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 100,
      maxWidth: 500,
      maxHeight: 500,
      compressFormat: ImageCompressFormat.png,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Image',
      ),
    );

    return croppedFile;
  }
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  UserInfo volunteer_info = UserInfo();
  List<String> _tumSehirler = [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Amasya',
    'Ankara',
    'Antalya',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Isparta',
    'Mersin',
    'Istanbul',
    'İzmir',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırklareli',
    'Kırşehir',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Kahramanmaraş',
    'Mardin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Şanlıurfa',
    'Uşak',
    'Van',
    'Yozgat',
    'Zonguldak',
    'Aksaray',
    'Bayburt',
    'Karaman',
    'Kırıkkale',
    'Batman',
    'Şırnak',
    'Bartın',
    'Ardahan',
    'Iğdır',
    'Yalova',
    'Karabük',
    'Kilis',
    'Osmaniye',
    'Düzce',
  ];
    var resim=null;
    String base64Image="";
  final _formKey = GlobalKey<FormState>();
  Future<bool> fetchData() async {
    //final url = 'http://172.20.10.2:3000/mobileMyInformation';
    final url = 'http://' + myip + '/mobileMyInformation';

    Volunteer volunteer = get_volunteer();
    
    int? id = volunteer.idvolunteer;
    final response = await http.post(
      Uri.parse(url),
      body: {
        'id': id.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      if (responseData == null) {
        return false;
      } else {
        for (var json in responseData) {
          myVolunteer = Volunteer(
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
       

        if (myVolunteer.volunteerName.toString() != "null") {
          _userNameController.text = myVolunteer.volunteerName.toString();
        }
        if (myVolunteer.volunteerFirstName.toString() != "null") {
          _nameController.text = myVolunteer.volunteerFirstName.toString();
        }
        if (myVolunteer.volunteerLastName.toString() != "null") {
          _surnameController.text = myVolunteer.volunteerLastName.toString();
        }
        if (myVolunteer.volunteerEposta.toString() != "null") {
          _emailController.text = myVolunteer.volunteerEposta.toString();
        }
        if (myVolunteer.volunteerPhoneNo.toString() != "null") {
          _phoneNoController.text = myVolunteer.volunteerPhoneNo.toString();
        }
        if (myVolunteer.volunteerBirthday.toString() != "null") {
          _birthDayController.text = myVolunteer.volunteerBirthday.toString();
        }
        if (myVolunteer.volunteerAddress.toString() != "null") {
          _addressController.text = myVolunteer.volunteerAddress.toString();
        }

        return true;
      }
    } else {
      return false;
    }
  }
   Future<String> imageToBase64(File imageFile) async {
  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);
  return base64Image;
}
  Uint8List base64StringToUint8List(String base64String) {
    List<int> byteList = base64.decode(base64String);
    return Uint8List.fromList(byteList);
  }

  Future<void> sendInformationData() async {
    String base64Image;
    debugPrint("res:"+_image.toString());
    if(_image.toString()!="null"){
      debugPrint("Boş değil!");
        base64Image = await imageToBase64(_image!);
    }else{
      debugPrint("Boş");
      base64Image="";
    }
   
    myVolunteer.volunteerName =_userNameController.text  ;
    myVolunteer.volunteerFirstName = _nameController.text ;
    myVolunteer.volunteerLastName = _surnameController.text;
    myVolunteer.volunteerEposta = _emailController.text;
    myVolunteer.volunteerPhoneNo = _phoneNoController.text;
    myVolunteer.volunteerBirthday = _birthDayController.text ;
    myVolunteer.volunteerAddress = _addressController.text ;
    myVolunteer.volunteerPhoto = base64Image;
    saveVolunteer(myVolunteer);
    final url = 'http://' + myip + '/mobileMyAccount';
    Volunteer volunteer = get_volunteer();
    int? id = volunteer.idvolunteer;

    final response = await http.post(
      
      Uri.parse(url),
      body: {
        'id': id.toString(),
        'name': _nameController.text.toString(),
        'surname': _surnameController.text.toString(),
        'email': _emailController.text.toString(),
        'phoneNo': _phoneNoController.text.toString(),
        'userName': _userNameController.text.toString(),
        'birthDay': _birthDayController.text.toString(),
        'address': _addressController.text.toString(),
        'gender': _genderController.text.toString(),
        'photo': base64Image.toString()
        ,
      },
    );
    volunteer.idvolunteer = id;
    volunteer.volunteerName = _userNameController.text.toString();
    volunteer.volunteerFirstName = _nameController.text.toString();
    volunteer.volunteerLastName = _surnameController.text.toString();
    volunteer.volunteerEposta = _emailController.text.toString();
    volunteer.volunteerPhoneNo = _phoneNoController.text.toString();
    volunteer.volunteerBirthday = _birthDayController.text.toString();
    volunteer.volunteerAddress = _addressController.text.toString();
    volunteer.volunteerGender = _genderController.text.toString();
    saveVolunteer(volunteer);

    if (response.statusCode == 200) {
      print('Veri başarıyla gönderildi');
    } else {
      // Hata durumu ile ilgili işlemleri burada yapabilirsiniz
      print('Hata oluştu: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
      Volunteer zaor = get_volunteer();
     debugPrint("photos"+zaor.volunteerPhoto.toString());
        if(zaor.volunteerPhoto.toString()=="null"){
          base64Image="";
        }else if(zaor.volunteerPhoto.toString()==""){
          base64Image="";
          }
        else{
          base64Image=zaor.volunteerPhoto.toString();
            resim = base64StringToUint8List(base64Image);
        }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: Container(
                        margin: EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          radius:50,
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
                ),
              Container(
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
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'İsminizi Girin',
                  // Customize the colors
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
                onSaved: (value) => volunteer_info.name = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'İsim boş olamaz';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              /////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: const Text(
                  'Soyisim',
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
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Soyisminizi Girin',
                  // Customize the colors
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
                onSaved: (value) => volunteer_info.surname = value!,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Soy isim boş olamaz';
                  }
                  return null;
                },
              ),

              Container(
                margin: EdgeInsets.only(top: 10.0),
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

              SizedBox(height: 10),
              ////////////////////////////////////////////////////

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Emailinizi girin',
                  // Customize the colors
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
                  volunteer_info.email = deger!;
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
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: const Text(
                  'Telefon No',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              TextFormField(
                controller: _phoneNoController,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Telefon numaranızı girin',
                  // Customize the colors
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
                keyboardType: TextInputType.phone,
                onSaved: (value) => volunteer_info.phoneNumber = value!,
                validator: (value) {
                  // Add validation for phone number if needed
                  return null;
                },
              ),
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: const Text(
                  'Kullanıcı adı',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                // height: 200,
                // width: 200,
                // decoration: BoxDecoration(color: Colors.amber),
              ),

              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Kullanıcı adınızı girin',
                  // Customize the colors
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
                onSaved: (value) => volunteer_info.nickname = value!,
                validator: (value) {
                  // Add validation for nickname if needed
                  return null;
                },
              ),
              SizedBox(height: 10),

              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: const Text(
                  'Doğum Tarihi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),

              TextFormField(
                controller: _birthDayController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  // labelText: 'Email',
                  hintText: 'Doğum tarihinizi girin',
                  // Customize the colors
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
                onSaved: (value) => volunteer_info.dob = value!,
                validator: (value) {
                  // Add validation for date of birth if needed
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(120, 158, 137, 10),
                      border: Border.all(
                        color: Colors.black, // Set the color of the border
                        width: 1.0, // Set the width of the border
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      "Nerede yaşıyorsunuz",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(120, 158, 137, 10),
                      border: Border.all(
                        color: Colors.black, // Set the color of the border
                        width: 1.0, // Set the width of the border
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButton<String>(
                      hint: Text('${myVolunteer.volunteerAddress.toString()}',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 25,
                      items: _tumSehirler
                          .map(
                            (String oankiSehir) => DropdownMenuItem(
                              child: Text(oankiSehir,
                                  style: TextStyle(color: Colors.black)),
                              value: oankiSehir,
                            ),
                          )
                          .toList(),
                      value: volunteer_info.selectedCity,
                      onChanged: (String? yeni) {
                        setState(() {
                          volunteer_info.selectedCity = yeni;
                          _addressController.text = yeni.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(120, 158, 137, 10),
                        border: Border.all(
                          color: Colors.black, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: const Text(
                        'Cinsiyet:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'Erkek',
                          groupValue: volunteer_info.selectedGender,
                          onChanged: (value) {
                            setState(() {
                              volunteer_info.selectedGender = value.toString();
                              _genderController.text = value.toString();
                            });
                          },
                        ),
                        Text(
                          'Erkek',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Radio(
                          value: 'Kadın',
                          groupValue: volunteer_info.selectedGender,
                          onChanged: (value) {
                            setState(() {
                              volunteer_info.selectedGender = value.toString();
                              _genderController.text = value.toString();
                            });
                          },
                        ),
                        Text(
                          'Kadın',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    /*
                    Text('Selected Gender: $selectedGender',
                        style: TextStyle(fontSize: 16)),
                    */
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  bool _validate = _formKey.currentState!.validate();
                  if (_validate) {
                    sendInformationData();
                    _formKey.currentState!.save();

                    String result = 'Güncelleme başarılı';
                    /*
                        'Name: $_name\nSurname: $_surname\nEmail: $_email\n'
                        'Password: $_password\nUsername: $_userName\nPhone Number: $_phoneNumber\n'
                        'Nickname: $_nickname\nDate of Birth: $_dob';
                      */

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.orange.shade300,
                        content: Text(
                          result,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                    _formKey.currentState!.reset();
                  }
                },
                child: Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

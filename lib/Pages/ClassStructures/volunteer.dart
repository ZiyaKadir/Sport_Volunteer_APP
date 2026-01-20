import 'package:hive_flutter/hive_flutter.dart';

part 'volunteer.g.dart';

Box<Volunteer> myBox = Hive.box<Volunteer>('my_Box');
final myip = 'sporgonulluleri.online';
//final myip = '10.0.4.103:3000';
String verificationEposta="";
@HiveType(typeId: 0)
class Volunteer extends HiveObject {
  @HiveField(0)
  int idvolunteer;
  @HiveField(1)
  String volunteerName;
  @HiveField(2)
  String volunteerFirstName;
  @HiveField(3)
  String volunteerLastName;
  @HiveField(4)
  String volunteerPassword;
  @HiveField(5)
  String volunteerEposta;
  @HiveField(6)
  String volunteerPhoneNo;
  @HiveField(7)
  String volunteerBirthday;
  @HiveField(8)
  String volunteerGender;
  @HiveField(9)
  String volunteerAddress;
  @HiveField(10)
  String volunteerPhoto;
  @HiveField(11)
  String volunteerJob;
  @HiveField(12)
  String volunteerLanguages;
  @HiveField(13)
  String volunteerBlacklist;

  Volunteer({
    required this.idvolunteer,
    required this.volunteerName,
    required this.volunteerFirstName,
    required this.volunteerLastName,
    required this.volunteerPassword,
    required this.volunteerEposta,
    required this.volunteerPhoneNo,
    required this.volunteerBirthday,
    required this.volunteerGender,
    required this.volunteerAddress,
    required this.volunteerPhoto,
    required this.volunteerJob,
    required this.volunteerLanguages,
    required this.volunteerBlacklist,
  });
}

Volunteer myVolunteer = Volunteer(
  idvolunteer: 0,
  volunteerName: "",
  volunteerFirstName: "",
  volunteerLastName: "",
  volunteerPassword: "",
  volunteerEposta: "",
  volunteerPhoneNo: "",
  volunteerBirthday: "",
  volunteerGender: "",
  volunteerAddress: "",
  volunteerPhoto: "",
  volunteerJob: "",
  volunteerLanguages: "",
  volunteerBlacklist: "",
);

Future<void> saveVolunteer(Volunteer volunteer) async {
  var _myBox = Hive.box<Volunteer>('my_box');
  await _myBox.put('volunteer', volunteer);
}

Volunteer get_volunteer() {
  var _myBox = Hive.box<Volunteer>('my_box');
  if(_myBox.get('volunteer')!=null){
    Volunteer my_return = _myBox.get('volunteer')!;
    return my_return!;
  }else{
    return myVolunteer;
  }
  
}

Future<void> deleteVolunteer() async {
  var _myBox = Hive.box<Volunteer>('my_box');
  try {
    // Delete the value associated with the key 'volunteer'
    await _myBox.delete('volunteer');
    print('Volunteer deleted successfully');
    myVolunteer.volunteerEposta="";
    myVolunteer.volunteerFirstName="";
    myVolunteer.volunteerLastName == "";
    myVolunteer.volunteerPhoneNo == "";
    myVolunteer.volunteerBirthday == "";
    myVolunteer.volunteerAddress == "";
    myVolunteer.volunteerAddress == "";
    myVolunteer.volunteerGender == "";

  } catch (e) {
    print('Error deleting volunteer: $e');
  }
}

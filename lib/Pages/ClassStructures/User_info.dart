// user_info.dart

class UserInfo {
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  String _userName = '';
  String _phoneNumber = '';
  String _nickname = '';
  String _dob = '';
  String? _selectedCity;
  String _selectedGender = '';

  // Getters
  String get name => _name;
  String get surname => _surname;
  String get email => _email;
  String get password => _password;
  String get userName => _userName;
  String get phoneNumber => _phoneNumber;
  String get nickname => _nickname;
  String get dob => _dob;
  String? get selectedCity => _selectedCity;
  String get selectedGender => _selectedGender;

  // Setters
  set name(String value) => _name = value;
  set surname(String value) => _surname = value;
  set email(String value) => _email = value;
  set password(String value) => _password = value;
  set userName(String value) => _userName = value;
  set phoneNumber(String value) => _phoneNumber = value;
  set nickname(String value) => _nickname = value;
  set dob(String value) => _dob = value;
  set selectedCity(String? value) => _selectedCity = value;
  set selectedGender(String value) => _selectedGender = value;
}

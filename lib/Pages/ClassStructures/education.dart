
class Education{

  int ideducation;
  String educationName;
  String educationStatus;
  String educationStartingDate;
  String educationFinishDate;
  String educationTeacher;
  String educationDescription;
  String educationPhoto;
  String educationLocation;

  Education({
    required this.ideducation,
    required this.educationName,
    required this.educationStatus,
    required this.educationStartingDate,
    required this.educationFinishDate,
    required this.educationTeacher,
    required this.educationDescription,
    required this.educationPhoto,
    required this.educationLocation,
  });

   factory Education.fromJson(Map<String, dynamic> json) => Education(
        ideducation: json["ideducation"],
        educationName: json["educationName"].toString(),
        educationStatus: json["educationStatus"].toString(),
        educationStartingDate: json["educationStartingDate"].toString(),
        educationFinishDate: json["educationFinishDate"].toString(),
        educationTeacher: json["educationTeacher"].toString(),
        educationDescription: json["educationDescription"].toString(),
        educationPhoto: json["educationPhoto"].toString(),
        educationLocation: json["educationLocation"].toString(),
    );
   Map<String, dynamic> toJson() => {
        "ideducation": ideducation,
        "educationName": educationName,
        "educationStatus": educationStatus,
        "educationStartingDate": educationStartingDate,
        "educationFinishDate": educationFinishDate,
        "educationTeacher": educationTeacher,
        "educationDescription": educationDescription,
        "educationPhoto": educationPhoto.toString(),
        "educationLocation": educationLocation,
    };
}


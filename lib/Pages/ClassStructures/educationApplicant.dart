
class educationApplicant{
  int applicantsStatus;
  int ideducation;
  String educationName;
  String educationStatus;
  String educationStartingDate;
  String educationFinishDate;
  String educationTeacher;
  String educationDescription;
  String educationPhoto;
  String educationLocation;

  educationApplicant({
    required this.applicantsStatus,
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

   factory educationApplicant.fromJson(Map<String, dynamic> json) => educationApplicant(
        applicantsStatus:json["applicantsStatus"],
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
        "applicantsStatus":applicantsStatus,
        "ideducation": ideducation,
        "educationName": educationName,
        "eventDescription": educationStatus,
        "eventStatus": educationStartingDate,
        "eventStartingDate": educationFinishDate,
        "eventFinishDate": educationTeacher,
        "eventLocation": educationDescription,
        "eventPhoto": educationPhoto.toString(),
        "educationLocation": educationLocation.toString(),
    };
}


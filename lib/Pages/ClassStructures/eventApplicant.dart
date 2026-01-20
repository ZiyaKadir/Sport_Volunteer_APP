
class Applicant{
  int applicantsStatus;
  int idevent;
  String eventName;
  String eventDescription;
  String eventStatus;
  String eventStartingDate;
  String eventFinishDate;
  String eventLocation;
  String eventPhoto;


  Applicant({
    required this.applicantsStatus,
    required this.idevent,
    required this.eventName,
    required this.eventDescription,
    required this.eventStatus,
    required this.eventStartingDate,
    required this.eventFinishDate,
    required this.eventLocation,
    required this.eventPhoto,
  });

   factory Applicant.fromJson(Map<String, dynamic> json) => Applicant(
        applicantsStatus:json["applicantsStatus"],
        idevent: json["idevent"],
        eventName: json["eventName"].toString(),
        eventDescription: json["eventDescription"].toString(),
        eventStatus: json["eventStatus"].toString(),
        eventStartingDate: json["eventStartingDate"].toString(),
        eventFinishDate: json["eventFinishDate"].toString(),
        eventLocation: json["eventLocation"].toString(),
        eventPhoto: json["eventPhoto"].toString(),
    );
   Map<String, dynamic> toJson() => {
        "applicantsStatus":applicantsStatus,
        "idevent": idevent,
        "eventName": eventName,
        "eventDescription": eventDescription,
        "eventStatus": eventStatus,
        "eventStartingDate": eventStartingDate,
        "eventFinishDate": eventFinishDate,
        "eventLocation": eventLocation,
        "eventPhoto": eventPhoto.toString(),
    };
}


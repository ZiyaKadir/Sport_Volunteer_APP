
class Event{

  int idevent;
  String eventName;
  String eventDescription;
  String eventStatus;
  String eventStartingDate;
  String eventFinishDate;
  String eventLocation;
  String eventPhoto;


  Event({
    required this.idevent,
    required this.eventName,
    required this.eventDescription,
    required this.eventStatus,
    required this.eventStartingDate,
    required this.eventFinishDate,
    required this.eventLocation,
    required this.eventPhoto,
  });

   factory Event.fromJson(Map<String, dynamic> json) => Event(
        idevent: json["id"],
        eventName: json["eventName"].toString(),
        eventDescription: json["eventDescription"].toString(),
        eventStatus: json["eventStatus"].toString(),
        eventStartingDate: json["eventStartingDate"].toString(),
        eventFinishDate: json["eventFinishDate"].toString(),
        eventLocation: json["eventLocation"].toString(),
        eventPhoto: json["eventPhoto"].toString(),
    );
   Map<String, dynamic> toJson() => {
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

Event myEvent= Event(
  idevent:0,
  eventStatus: "",
  eventName: "",
  eventDescription: "",
  eventStartingDate: "",
  eventFinishDate: "",
  eventLocation: "",
  eventPhoto: "",
);
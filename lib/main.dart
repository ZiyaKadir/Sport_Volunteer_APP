import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Pages/Route_generator.dart';
import 'Pages/Certificate_page.dart';
import 'Pages/Main_page.dart';
import 'Pages/ClassStructures/event.dart';
import 'Pages/ClassStructures/volunteer.dart';
import 'Pages/Services/notifi_service.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'Pages/Services/notifi_service.dart';
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    preInitializeFunction();
    return Future.value(true);
  });
}

 int flag=0;
  Future<void> fetchData2() async {

  final channel = IOWebSocketChannel.connect('ws://'+myip);
 channel.stream.listen(onDataReceived);
 }
@override
void onDataReceived(dynamic data) {
    
   try {
    // Gelen veriyi JSON formatına çevir
    Map<String, dynamic> jsonData = json.decode(data);

    // JSON verilerini Event sınıfına uygun şekilde al
    Event myEvent = Event(
      idevent: 0, // Burada bir id değeri belirlemeniz gerekiyor, eğer varsa kullanabilirsiniz.
      eventName: jsonData['eventName'],
      eventDescription: jsonData['eventDescription'],
      eventStatus: "",
      eventStartingDate: jsonData['eventStartingDate'],
      eventFinishDate: jsonData['eventFinishDate'],
      eventLocation: jsonData['eventLocation'],
      eventPhoto: jsonData['eventPhoto'].toString(),
    );
    if(data!=""){
      debugPrint('WebSocket Data: $data');

      NotificationService notificationService = NotificationService();
      
      notificationService.showNotification(title: "yeni etkinlik",body:"");
        
    }
    // Event nesnesini kullanabilirsiniz
    print('Event Name: ${myEvent.eventName}');
    print('Event Description: ${myEvent.eventDescription}');
    // Diğer özellikleri de kullanabilirsiniz.
  } catch (e) {
    // Hata durumunda hatayı yazdır
    print('Exception during data processing: $e');
  }
      
     


   
  
  }
void preInitializeFunction() async {
  // Burada uygulama başlatılmadan önce yapılması gereken işlemleri gerçekleştirebilirsiniz

  // Örnek: Internet bağlantısını kontrol etmek
  bool hasInternetConnection = await checkInternetConnection();

  if (hasInternetConnection) {
    fetchData2();
    debugPrint('Uygulama başlatılmadan önce internet bağlantısı kontrolü başarılı');
  } else {
    debugPrint('Uygulama başlatılmadan önce internet bağlantısı kontrolü başarısız');
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    // Cihaz internet bağlantısına sahip
    return true;
  } else {
    // Cihaz internet bağlantısına sahip değil
    return false;
  }
}



void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(VolunteerAdapter());

 
  await Hive.openBox<Volunteer>('my_box');
 WidgetsFlutterBinding.ensureInitialized();
 

 await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager().registerOneOffTask(
    "1", // unique task name
    "simpleTask", // task name
  );
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(07, 67, 49, 86)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}


class MyHomePageState extends State<MyHomePage> {
  
 





  
  @override
  Widget build(BuildContext context) {
    NotificationService().initNotification(context);
    preInitializeFunction();
    return Home_page();
  }
}

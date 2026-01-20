import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applicaiton_pages/Pages/Reset_password_page.dart';
import 'Certificate_page.dart';
import 'Main_page.dart';
import 'Past_event.dart';
import 'Settings.dart';
import 'Sign_in_page.dart';
import 'Sign_up_page.dart';
import 'Veritification_page.dart';
import 'My_eventApplications.dart';
import 'My_educationApplicants.dart';
import 'forget_mail.dart';
import 'verification_forget_pass.dart';
class RouteGenerator {
  static Route<dynamic>? _routeOlustur(
      Widget gidilecekWidget, RouteSettings settings) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android)
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
    else
      return CupertinoPageRoute(
        settings: settings,
        builder: (context) => gidilecekWidget,
      );
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _routeOlustur(Home_page(), settings);
      case '/settings_page':
        return _routeOlustur(Settings(), settings);
      case '/past_event_page':
        return _routeOlustur(Past_event(), settings);
      case '/certificate_page':
        return _routeOlustur(Certificate(), settings);
      case '/Sign_in_page':
        return _routeOlustur(Sign_in(), settings);
      case '/Sign_up_page':
        return _routeOlustur(Sign_up(), settings);
      case '/reset_page':
        return _routeOlustur(reset_password(), settings);
      case '/verification_page':
        return _routeOlustur(Verification(), settings);
      case '/My_eventApplications':
        return _routeOlustur(My_eventApplications(), settings);
      case '/My_educationApplications':
        return _routeOlustur(My_educationApplications(), settings);  
      case '/forget_mail_page':
        return _routeOlustur(Forget_mail(), settings);
      case '/verification_forget_page':
        return _routeOlustur(Verification_forget(), settings);  
      case '/reset_page':
        return _routeOlustur(reset_password(), settings);


      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('404'),
            ),
            body: Center(
              child: Text('Sayfa Bulunamadı'),
            ),
          ),
        );
    }
  }
}

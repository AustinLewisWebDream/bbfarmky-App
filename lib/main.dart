import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bbfarmky/home/home.dart';
import 'package:flutter/material.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    return data;
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    return notification;
  }

  // Or do other work.
}
void main() => runApp(App());

class App extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
    void initState() {

_firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(4, 116, 188, 1),
        accentColor: Color.fromRGBO(252, 172, 25, 1),
        textTheme: TextTheme(
          title: TextStyle(color: Color.fromRGBO(252, 172, 25, 1), fontFamily: 'Lato',fontSize: 50.0),
          body2: TextStyle(color: Colors.white),
          subtitle: TextStyle(fontSize: 25.0)
        )
      ),
      home: HomeMenu(),
    );
  }
}
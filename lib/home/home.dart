import 'dart:math';

import '../storage/store_notification.dart';
import 'package:bbfarmky/about/about_route.dart';
import 'package:bbfarmky/home/footer.dart';
import 'package:bbfarmky/home/menu_item.dart';
import 'package:bbfarmky/my_widgets/Badge.dart';
import 'package:bbfarmky/news/NewsRoute.dart';
import 'package:bbfarmky/orders/orders_route.dart';
import 'package:bbfarmky/products/product_route.dart';
import 'package:bbfarmky/schedule/schedule_route.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';




Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print('Background message Recieved' + message.toString());
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    var notification = message['notification'];
    var title = notification['title'];
    var body = notification['body'];
    FirebaseNotifications.add(FirebaseNotification(body: body, title: title, id: Random().nextInt(1000)));
    return data;
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    var notification = message['notification'];
    var title = notification['title'];
    var body = notification['body'];
    FirebaseNotifications.add(FirebaseNotification(body: body, title: title, id: Random().nextInt(1000)));
    return notification;
  }

  // Or do other work.
}

class HomeMenu extends StatefulWidget {
  @override
  State<HomeMenu> createState() {
    return _HomeMenu();
  }
}

class _HomeMenu extends State<HomeMenu> {
  Future<int> numNotifications;
  bool contactMenuOpen = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // firebaseNotificationTest();
    // FirebaseNotifications.add(FirebaseNotification(body: 'This is the third test of the FirebaseMessaging System. From here, we should be able to successfully delete one of these notifications and it show up correctly', title: 'Title Test Num 3', id: Random().nextInt(1000)));
    _firebaseMessaging.autoInitEnabled().then((bool enabled) => print(enabled));
    _firebaseMessaging.setAutoInitEnabled(true).then((_) => _firebaseMessaging.autoInitEnabled().then((bool enabled) => print(enabled)));
    _firebaseMessaging.configure(
      onBackgroundMessage: myBackgroundMessageHandler,
        onMessage: (Map<String, dynamic> message) async {
          print('Onmessage...');
          print("onMessage: $message");
          var notification = message['notification'];
          var title = notification['title'];
          var body = notification['body'];
          FirebaseNotifications.add(FirebaseNotification(body: body, title: title, id: Random().nextInt(1000)));
        },
        
        onLaunch: (Map<String, dynamic> message) async {
          print('On Launch');
          print("onLaunch: $message");
          var notification = message['notification'];
          var title = notification['title'];
          var body = notification['body'];
          FirebaseNotifications.add(FirebaseNotification(body: body, title: title, id: Random().nextInt(1000)));
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume');
          print("onResume: $message");
          var notification = message['notification'];
          var title = notification['title'];
          var body = notification['body'];
          FirebaseNotifications.add(FirebaseNotification(body: body, title: title, id: Random().nextInt(1000)));
        },
      );
      _firebaseMessaging.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
      _firebaseMessaging.onTokenRefresh.listen((data) {
        print('Refresh Token: $data');
      });
      _firebaseMessaging.getToken().then((String token) {
        assert(token != null);
      });
      setState(() {
        this.numNotifications = FirebaseNotifications.getNumNotifications();
      });
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/images/logo.png',
                        height: height/5, width: height/5),
                    Container(
                        margin: EdgeInsets.all(18.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            'Fresh, Local, and Naturally Grown!',
                            style: TextStyle(
                                color: Color.fromRGBO(252, 172, 25, 1),
                                fontFamily: 'Lato',
                                fontSize: 25.0),
                          ),
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: MenuItem(
                                  itemText: 'Products',
                                  imagePath: 'assets/images/products.png',
                                  route: ProductsRoute(),
                                ),
                              ),
                              MenuItem(
                                itemText: 'Orders',
                                imagePath: 'assets/images/orders.png',
                                route: OrdersRoute(),
                              ),
                              MenuItem(
                                itemText: 'Schedule',
                                imagePath: 'assets/images/schedule.png',
                                route: ScheduleRoute(),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Stack(children: <Widget>[
                                MenuItem(
                                  itemText: 'News',
                                  imagePath: 'assets/images/news.png',
                                  route: NewsRoute(),
                                ),
                                FutureBuilder<int>(
                                  future: numNotifications,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData || snapshot.data != null) {
                                      if(snapshot.data == 0) {return Container();}
                                      print('This is the snapshot data: ' + snapshot.data.toString());
                                      return Badge(snapshot.data);
                                    }
                                    else {
                                      return Container();
                                    }
                                  },  
                                )
                              ],),
                              MenuItem(
                                itemText: 'Contact',
                                imagePath: 'assets/images/contact.png',
                                callback: openContactMenu,
                              ),
                              MenuItem(
                                itemText: 'About',
                                imagePath: 'assets/images/about.png',
                                route: AboutRoute(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Footer()
                  ],
                ),
                PopupMenu(
                  open: contactMenuOpen,
                  closePopup: closePopup,
                )
              ],
            )),
      ),
    );
  }

  void closePopup() {
    setState(() {
      contactMenuOpen = false;
    });
  }

  void openContactMenu() {
    setState(() {
      contactMenuOpen = true;
    });
  }


}

class PopupMenu extends StatelessWidget {
  final bool open;
  final Function closePopup;

  PopupMenu({this.open, this.closePopup});

  @override
  Widget build(BuildContext context) {
    if (open) {
      return Center(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    closePopup();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10, top: 10),
                    child: Container(
                      child: Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL("tel://5026001004");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.phone),
                      Container(
                        child: Text('Call', style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('sms:(502)600-1004');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.sms),
                      Container(
                        child: Text('Text', style: TextStyle(fontSize: 20)),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL(
                        'mailto:info@bbfarmky.com?subject=Inquiry');
                  },
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.email),
                        Text('Email', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

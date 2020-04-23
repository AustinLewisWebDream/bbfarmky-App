



import 'package:bbfarmky/my_widgets/loading_indicator.dart';
import 'package:bbfarmky/news/NewsCard.dart';

import '../storage/store_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsRoute extends StatefulWidget {
  @override
  State<NewsRoute> createState() {
    return _NewsRoute();
  }
}


class _NewsRoute extends State<NewsRoute> {
  List<FirebaseNotification> notifications;

  @override
  void initState() {
    FirebaseNotifications.getList().then((notifList) => {
      this.notifications = notifList
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News'),),
      body: FutureBuilder<List<FirebaseNotification>> (
        future: FirebaseNotifications.getList(), 
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            return ListView(children: snapshot.data.map((notification) => NewsCard(notification)).toList());
          } else {
            return LoadingIndicator();
          }
          
        },) 

      );
    
  }
}
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:bbfarmky/storage/store_notification.dart';

class NewsCard extends StatefulWidget {
  final notification;
  NewsCard(this.notification);
  @override
  State<StatefulWidget> createState() {
    return _NewsCard(this.notification);
  }

}

class _NewsCard extends State<NewsCard> {
  final FirebaseNotification notification;
  _NewsCard(this.notification);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
          child: Card(
          margin: EdgeInsets.all(5.0),
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Padding( padding: EdgeInsets.only(bottom: 5), child: Align( alignment: Alignment.centerLeft, child: AutoSizeText(notification.title, maxLines: 1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),)),
                Align( alignment: Alignment.centerLeft, child: Text(notification.body, style: TextStyle(fontSize: 12)),),
              ],
            ),
          ),
        ),
      key: ObjectKey(notification.id),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        print('Item with id ' + notification.id.toString() + ' was dismissed...');
        FirebaseNotifications.removeById(notification.id);
      },
    );
  }

}
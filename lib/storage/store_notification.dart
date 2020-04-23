
// Finds path to either NSDocumentDirectory (IOS) or AppData (Android)
import 'dart:convert';
import 'dart:io';
import 'dart:math';


import 'package:path_provider/path_provider.dart';

void firebaseNotificationTest() async {
  FirebaseNotification first = FirebaseNotification(title: 'Title 1', body: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean nec dapibus nisl. Sed interdum pharetra sagittis. Phasellus ut mauris non mi dignissim maximus ac at felis. Morbi viverra vitae lectus eget tincidunt. ', id: Random().nextInt(300));
  FirebaseNotification second = FirebaseNotification(title: 'Title 2', body: ' vitae egestas neque blandit ut. Mauris elementum iaculis urna, non tempus justo aliquet eu. Quisque vel urna consectetur, molestie leo suscipit, fermentum massa. In vel dui id nisl consequat rutrum ut vel enim', id: Random().nextInt(300));
  FirebaseNotification third = FirebaseNotification(title: 'Title 3', body: 'tesque magna quis dignissim. Cras congue hendrerit eros vitae venenatis. Nulla gravida, est quis mollis sodales, orci tortor aliquet diam, nec hendrerit ligula nulla quis urna. Suspendisse eu elit at sem dignissim rutrum. Fusce fermentum ultrices lectus vitae volutpat. Ut et lacus ac eros ', id: Random().nextInt(300));

  await FirebaseNotifications.add(first);
  await FirebaseNotifications.add(second);
  await FirebaseNotifications.add(third);
}


class FirebaseNotification {
  String title;
  String body;
  int id;

  FirebaseNotification({this.title, this.body, this.id});

  Map<String, String> toJson() => 
  {
    'title': title,
    'body': body,
    'id': id.toString()
  };

  void printDebug() {
    print('$title');
    print('$body');
    print(id.toString());
  }
}


class FirebaseNotifications {
  static List<FirebaseNotification> notifications = List();


  // FirebaseNotifications({this.notifications});
  FirebaseNotifications() {
    _readFile().then((fileContents) => {
      notifications = fromJson(fileContents)
    });
  }

  

  static Future<List<FirebaseNotification>> getList() async {
    String contents = await _readFile();
    List<FirebaseNotification> result = fromJson(contents);
    if(result == null) {
      return new List();
    }
    return result;
  }

  static Future<void> add(FirebaseNotification newNotif) async {
    await syncFile();
    notifications.add(newNotif);
    await _writeFile(toJson());
  }

  static Future<void> remove(FirebaseNotification notification) async {
    notifications.remove(notification);
    await _writeFile(toJson());
  }

  static Future<void> removeById(int id) async {
    await syncFile();
    print('Notifications currently in the database: ' + notifications.toString());
    notifications.forEach((notif) {
      print(notif.id.toString());
    });
    notifications.removeWhere((notification) => notification.id == id);
    await _writeFile(toJson());
  }

  static Future<int> getNumNotifications() async {
    String contents = await _readFile();
    List<FirebaseNotification> result = fromJson(contents);
    if(result == null) {
      return 0;
    }
    print('This is the result of the getNumNotifications function: ' + result.toString());
    return result.length;
  }

  static Future<void> syncFile() async {
    String contents = await _readFile();
    List<FirebaseNotification> result = fromJson(contents);
    if(result == null) {
      return 0;
    }
    notifications = result;
  }

  static String toJson() {
    List<Map<String,String>> jsonList = notifications.map((notification) => notification.toJson()).toList();
    Map<String, dynamic> map = { 'notifications': jsonList };
    String result = jsonEncode(map);
    return result;  
  }

  static List<FirebaseNotification> fromJson(String json) {
    if(json == null || json.length == 0) {return new List();}
    
    Map<String, dynamic> decoded = jsonDecode(json);
    dynamic notifStrings = decoded['notifications'];

    List<FirebaseNotification> result = List(); 
    
    notifStrings.forEach((notif) {
      FirebaseNotification newNotif = FirebaseNotification(title: notif['title'], body: notif['body'], id: int.parse(notif['id']));
      result.add(newNotif);
    });

    return result;
  }
  static Future<File> _writeFile(String jsonString) async {
    final file = await _localFile;
    return file.writeAsString(jsonString);
  }
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/bbfarmky.txt');
  }
  static Future<String> _readFile() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return null;
    }
  }
}


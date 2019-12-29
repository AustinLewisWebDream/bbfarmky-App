import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
        Expanded(
                  child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 FooterIcon(imagePath: 'assets/images/facebook.png', url: 'https://www.facebook.com/bbfarmky/',),
                 FooterIcon(imagePath: 'assets/images/twitter.png', url: 'https://twitter.com/bbfarmky',),
                 FooterIcon(imagePath: 'assets/images/instagram.png', url: 'https://www.instagram.com/bbfarmky/')
                ],
              )),
        );
  }
  
}

class FooterIcon extends StatelessWidget {
  final String imagePath;
  final String url;
  FooterIcon({this.imagePath, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            _launchURL(url);
          },
          child: Container(
        margin: EdgeInsets.all(10.0),
          child: Image.asset(
        imagePath,
        width: 40.0,
        height: 40.0,
      )),
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



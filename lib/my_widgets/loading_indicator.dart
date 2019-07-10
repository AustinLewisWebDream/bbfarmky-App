import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(alignment: Alignment.center ,child: CircularProgressIndicator(),) 
    );
  }

}
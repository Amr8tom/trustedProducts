import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("This application Designed to help u to find high quality products",
                  overflow: TextOverflow.ellipsis,
                ),
                Text("In this app we collected more than 30K product around the world",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text("You can scan the barcode fot the product and we will recommend it or not",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text("We are Working on update our database ",
                  overflow: TextOverflow.ellipsis,
                ),
                Text("The update will be an awesome version ",
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

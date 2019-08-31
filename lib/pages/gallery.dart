import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('گالری تصاویر'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                print('on press');
              },
              icon: Icon(Icons.arrow_forward),
            )
          ],
          elevation: 0.0,
        ),
        body: Center(
          child: Text('گالری تصاویر'),
        ),
      ),
    );
  }
}

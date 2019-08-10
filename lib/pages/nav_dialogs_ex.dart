import 'package:flutter/material.dart';

class DialogsExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Align(
        child: RaisedButton(
          child: Icon(Icons.calendar_today),
          onPressed: () {
            // showBottomSheet(
            //     context: context,
            //     builder: (context) =>

            //     GestureDetector(
            //       onTap: (){
            //         Navigator.pop(context);
            //       },
            //                           child: Container(
            //             color: Colors.red,
            //             child: Center(child: Text("ssssss"),),
            //           ),
            //     ));

            showBottomSheet<String>(
                context: context,
                builder: (BuildContext context) => Container(
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black12)),
                      ),
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        primary: false,
                        children: _buildList(),
                      ),
                    ));
          },
        ),
      ),
    ));
  }

  List<Widget> _buildList() {
    return [
      Row(
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('text1'),
          GestureDetector(
            child: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              print('on tap');
            },
          )
        ],
      ),
      ListTile(
        dense: true,
        title: Text('This is a bottom sheet'),
      ),
      ListTile(
        dense: true,
        title: Text('Click OK to dismiss'),
        selected: true,
      ),
      ButtonTheme.bar(
        // make buttons use the appropriate styles for cards
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    ];
  }
}

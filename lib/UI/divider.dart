import 'package:flutter/material.dart';
class CatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(top: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 9,
          height: 25,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "تورهای ویژه خارجی",
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: 130,
          height: 1,
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25) ,),
            height: 20,
            elevation: 0.0,
            color: Theme.of(context).accentColor,
            
            child: Text('مشاهده همه',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white,
                )),
            onPressed: () {},
        ),
          )
      ],
    ),
  );
  }
}
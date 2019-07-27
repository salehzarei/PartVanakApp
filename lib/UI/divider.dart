import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model.dart';

class CatDivider extends StatelessWidget {
  final int toureTypeindex;

  const CatDivider({Key key, this.toureTypeindex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Padding(
          padding: EdgeInsets.only(top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 5,
                height: 25,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5))),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                model.touretypes[toureTypeindex]['title'],
                style: Theme.of(context).textTheme.subhead,
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  height: 0.5,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: 20,
                    elevation: 0.0,
                    color: Theme.of(context).primaryColor,
                    child: Text('مشاهده همه',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        )),
                    onPressed: () => Navigator.pushNamed(
                        context, model.touretypes[toureTypeindex]['pushNamed'])),
              )
            ],
          ),
        );
      },
    );
  }
}

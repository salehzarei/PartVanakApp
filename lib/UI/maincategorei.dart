import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_flutter/scoped_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../coustomIcon/toure_icons_icons.dart';

class HomeCategorei extends StatefulWidget {
  final Function(int index) tapedcategory;
  HomeCategorei({Key key, this.tapedcategory}) : super(key: key);

  _HomeCategoreiState createState() => _HomeCategoreiState();
}

class _HomeCategoreiState extends State<HomeCategorei> {
  List<bool> selected = [true, false, false, false];

  _selectedChange(index) {
    /// ایندکس دکمه را به ویجت والد ارسال می کند
    widget.tapedcategory(index);

    /// تغییر وضعیت دکمه ها
    switch (index) {
      case 0:
        {
          setState(() {
            selected = [true, false, false, false];
          });
        }
        break;

      case 1:
        {
          setState(() {
            selected = [false, true, false, false];
          });
        }
        break;

      case 2:
        {
          setState(() {
            selected = [false, false, true, false];
          });
        }
        break;

      case 3:
        {
          setState(() {
            selected = [false, false, false, true];
          });
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Container(
          height: 102,
          child: ListView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              GestureDetector(
                child: HomeCategoriItem(
                  icon: ToureIcons.around,
                  title: 'تورهای خارجی',
                  selected: selected[0],
                ),
                onTap: () {
                  if (!selected[0])
                    _selectedChange(0);
                  else
                    Navigator.pushNamed(
                        context, model.touretypes[0]['pushNamed']);
                },
              ),
              GestureDetector(
                child: HomeCategoriItem(
                  icon: ToureIcons.azadi,
                  title: 'تورهای داخلی',
                  selected: selected[1],
                ),
                onTap: () {
                  if (!selected[1])
                    _selectedChange(1);
                  else
                    Navigator.pushNamed(
                        context, model.touretypes[1]['pushNamed']);
                },
              ),
              GestureDetector(
                child: HomeCategoriItem(
                  icon: ToureIcons.first_day,
                  title: 'تورهای یکروزه',
                  selected: selected[2],
                ),
                onTap: () {
                  if (!selected[2])
                    _selectedChange(2);
                  else
                    Navigator.pushNamed(
                        context, model.touretypes[2]['pushNamed']);
                },
              ),
              GestureDetector(
                child: HomeCategoriItem(
                  icon: ToureIcons.stopwatch,
                  title: 'تورهای لحظه آخری',
                  selected: selected[3],
                ),
                onTap: () {
                  if (!selected[3])
                    _selectedChange(3);
                  else
                    Navigator.pushNamed(
                        context, model.touretypes[3]['pushNamed']);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class HomeCategoriItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;

  const HomeCategoriItem({Key key, this.title, this.icon, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: selected
                ? Theme.of(context).accentColor.withOpacity(0.5)
                : Colors.grey.shade300,
            radius: 35,
            child: Icon(
              icon,
              size: 33,
              color: selected ? Colors.brown : Colors.brown.shade200,
            ),
          ),
          SizedBox(height: 4),
          Text(title,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.brown : Colors.brown.shade200))
        ],
      ),
    );
  }
}

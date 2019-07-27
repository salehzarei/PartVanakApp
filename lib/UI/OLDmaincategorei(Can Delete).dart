import 'package:flutter/material.dart';
import '../coustomIcon/toure_icons_icons.dart';


class MainCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/foreigntourelist'),
                child: HomeItem('تورهای خارجی', ToureIcons.around)),
            GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/internaltourelist'),
                child: HomeItem('تورهای داخلی', ToureIcons.azadi)),
            HomeItem('تورهای طبیعتگردی', ToureIcons.tent)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          child: CustomPaint(
            painter: ShapesPainter(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () => //_ackAlert(context), 
                null,
                child: HomeItem(
                    'تورهای لاکچری', ToureIcons.crown_of_royal_design)),
            CustomPaint(
              painter: VerLine(),
            ),
            GestureDetector(
                onTap: () => null,
                child: HomeItem('تورهای یکروزه', ToureIcons.first_day)),
            CustomPaint(
              painter: VerLine(),
            ),
            GestureDetector(
                onTap: () => null,
                child: HomeItem('تورهای لحظه آخری', ToureIcons.stopwatch))
          ],
        ),
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  String title;
  IconData icon;
  HomeItem(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 32,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.grey.withOpacity(0.5);
    paint.strokeWidth = 0.5;

    canvas.drawLine(Offset(-200, 0), Offset(200, 0), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class VerLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.grey.withOpacity(0.5);
    paint.strokeWidth = 0.5;

    canvas.drawLine(Offset(0, -125), Offset(0, 40), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

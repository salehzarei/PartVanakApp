import 'package:flutter/material.dart';
import '../model/toure_model.dart';
import 'touretitle.dart';

class SpecialToureScrollTitle extends StatelessWidget {
  final List<Toure> specialtours;

  const SpecialToureScrollTitle({this.specialtours, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 200,
        child: specialtours.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: specialtours.length,
                shrinkWrap: true,
                // ضروری است
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ToureTitle(
                      toure: specialtours[index],
                    ),
                  );
                },
              ));
  }
}

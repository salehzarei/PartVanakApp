import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
child: Container(
  width: 250,
  decoration: BoxDecoration(
    color: Colors.blueAccent.shade700.withOpacity(0.9)
  ),
)
    );
}}
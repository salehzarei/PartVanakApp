import 'package:flutter/material.dart';

class Contact {

  final String name;
  final String cell;
  final String message;
  final String email;
  final int type;

  Contact(@required this.name,this.cell,this.email,this.message,@required this.type);
}

class ContactSubject {

  final String id;
  final String title;
 
  ContactSubject({this.id,this.title});
}
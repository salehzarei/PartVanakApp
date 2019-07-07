import 'package:flutter/material.dart';

class Register {
  final String name;
  final String family;
  final int cell;
  final String email;
  final String code;
  final int pass;
  final String token;

  Register(@override this.name, this.family, this.cell, this.email, this.code,
      this.pass, this.token);
}

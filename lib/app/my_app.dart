import 'package:flutter/material.dart';

abstract class MyApp {
  bool jailbroken = false;
  void setJailbroken(bool value) {
    jailbroken = value;
  }

  Widget build(BuildContext context);
}

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
    }
    return isFirstLaunch;
  }

  int generatePin() {
    final random = Random();
    String pin = '';
    for (int i = 0; i < 6; i++) {
      pin += random.nextInt(10).toString();
    }
    return int.parse(pin);
  }

  void storePin(int p) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('pin', p);
  }

  Future<int> getPin() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      int h = prefs.getInt('pin') ?? 0;
      return h;
    } catch (e) {}
    return 0;
  }
}

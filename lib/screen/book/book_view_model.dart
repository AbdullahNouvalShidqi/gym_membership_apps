import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookViewModel with ChangeNotifier {
  DateTime? _currentBackPressTime;

  void Function() backToHomeOnTap(BuildContext context) {
    return () {
      DateTime now = DateTime.now();
      if ((_currentBackPressTime == null ||
          now.difference(_currentBackPressTime!) > const Duration(milliseconds: 2000))) {
        _currentBackPressTime = now;
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: "Press back to home again, to go back to home");
        return;
      }
      _currentBackPressTime = null;
      Fluttertoast.cancel();
      Navigator.popUntil(context, (route) => route.isFirst);
    };
  }
}

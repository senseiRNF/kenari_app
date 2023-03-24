import 'package:flutter/material.dart';

class MoveToPage {
  BuildContext context;
  Widget target;
  Function? callback;

  MoveToPage({
    required this.context,
    required this.target,
    this.callback,
  });

  void go() async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext targetContext) => target)).then((dynamic result) {
      if(callback != null) {
        callback!(result);
      }
    });
  }
}

class ReplaceToPage {
  BuildContext context;
  Widget target;

  ReplaceToPage({
    required this.context,
    required this.target,
  });

  void go() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext targetContext) => target));
  }
}

class BackFromThisPage {
  BuildContext context;
  dynamic callbackData;

  BackFromThisPage({
    required this.context,
    this.callbackData,
  });

  void go() {
    Navigator.of(context).pop(callbackData);
  }
}

class RedirectToPage {
  BuildContext context;
  Widget target;

  RedirectToPage({
    required this.context,
    required this.target,
  });

  void go() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext targetContext) => target), (route) => false);
  }
}
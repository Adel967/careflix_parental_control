import 'package:flutter/material.dart';

import '../ui/waiting_widget.dart';

class LoadingOverlay {
  BuildContext _context;

  void hide() {
    Navigator.of(_context).pop();
  }

  void show() async {
    await showDialog(
      context: _context,
      barrierDismissible: false,
      barrierColor: Colors.white.withAlpha(150),
      builder: (BuildContext context) => WaitingWidget(),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(() => hide());
  }

  LoadingOverlay._create(this._context);

  factory LoadingOverlay.of(BuildContext context) =>
      LoadingOverlay._create(context);
}

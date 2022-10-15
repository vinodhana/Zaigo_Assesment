import 'package:flutter/material.dart';
import 'package:flutter_videos/src/widgets/dialog_widget.dart';

pushNamedAndRemoveAll(BuildContext context, String routeName) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
  Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false);
}

showLogoutDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: const DialogWidget(),
        );
      });
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppSnackBar {
  final String? message;
  final String? actionText;
  final VoidCallback? onPressed;
  final bool? isPositive;

  const AppSnackBar(
      {@required this.message,
      this.actionText,
      this.onPressed,
      this.isPositive = false});

  Future<void> showAppSnackBar(BuildContext context) async {
    MaterialButton? actionButton;
    if (actionText != null && actionText!.isNotEmpty && onPressed != null) {
      actionButton = MaterialButton(
        onPressed: onPressed,
        child: Text(
          actionText!,
          style: const TextStyle(
              color: Colors.black,
              fontSize:12,
              fontWeight: FontWeight.w600),
        ),
      );
    }
    await Flushbar(
      backgroundColor: isPositive! ? Colors.greenAccent : Colors.red,
      messageText: Text(message!,
          textAlign: TextAlign.left,
          softWrap: true,
          style: const TextStyle(
              color: Colors.white,
              fontSize:12)),
      duration: const Duration(seconds: 3),
      mainButton: actionButton,
    )
      .show(context);
  }
}

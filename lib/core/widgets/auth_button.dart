import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  final String text;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

const AuthButton({
        super.key,
        required this.text,
        this.onPressed,
         this.backgroundColor,
});

@override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: onPressed,
         child: Text(text)),
    );

  }

}
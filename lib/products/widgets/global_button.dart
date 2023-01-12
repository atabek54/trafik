import 'package:flutter/material.dart';

import '../texts/text.dart';

class GlobalButtonWidget extends StatelessWidget {
  const GlobalButtonWidget({
    Key? key,
    required this.loginButtonOnPressed,
    required this.text,
  }) : super(key: key);
  final VoidCallback loginButtonOnPressed;

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 90),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).buttonColor
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: loginButtonOnPressed != null
            ? () {
                loginButtonOnPressed();
              }
            : null,
        child: Text(
          text,
          style: TextsStyles.elevatedButtonText,
        ),
      ),
    );
  }
}

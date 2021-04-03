
import 'package:flutter/material.dart';
import 'package:togolist/const/FontSettings.dart';

class GradatedTextButton extends StatelessWidget {
  String text;
  Function onPressed = (){};

  GradatedTextButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..shader = FontShader
                    .linearGradientShader
          ),
        ),
      ),
    );
  }
}
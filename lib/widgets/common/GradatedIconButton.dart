
import 'package:flutter/material.dart';

class GradatedIconButton extends StatelessWidget {

  Function onPressed;
  Icon icon;

  GradatedIconButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 2.0,
        onPressed: () => onPressed(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: const [
                Color(0xffffab88),
                Color(0xffff7f50),
              ],
            ),
          ),
          child: icon,
        )
    );
  }
}
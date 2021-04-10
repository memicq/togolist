import 'package:flutter/material.dart';

class AccountViewItemCard extends StatelessWidget {
  Widget content;
  Color backgroundColor;
  double elevation;
  Function onTap = (){};
  AccountViewItemCard({
    this.content,
    this.backgroundColor = Colors.white,
    this.elevation = 0.5,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.backgroundColor,
      elevation: this.elevation,
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          width: double.infinity,
          child: this.content,
        ),
      ),
    );
  }
}
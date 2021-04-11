import 'package:flutter/material.dart';

class PlaceDetailItemCard extends StatelessWidget {
  String title;
  Widget content;

  PlaceDetailItemCard({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.5,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                this.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                )
            ),
            SizedBox(height: 10),
            this.content,
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class BackgroundText extends StatelessWidget {
  final text;

  BackgroundText({required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: WidgetSpan(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color.fromRGBO(20, 20, 20, .8)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13),
          overflow: TextOverflow.ellipsis,
        ),
      )),
    );
  }
}

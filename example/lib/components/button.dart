
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button(this.title, this.onClick, { Key? key }) : super(key: key);

  String title;
  Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 150,
        height: 50,
        child: ElevatedButton(
          child: Text(title, textAlign: TextAlign.center),
          onPressed: () {
            onClick();
          },
        ),
      ),
    );
  }
}
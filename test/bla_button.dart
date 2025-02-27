import 'package:blablabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: BlaButton(
            Text('Click Me'),
            onPressed: () {
              print('Button Pressed!');
            },
            icon: Icons.thumb_up,
            isPrimary: true,
          ),
        ),
      ),
    ),
  );
}

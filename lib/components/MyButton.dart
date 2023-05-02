import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
MyButton({required this.color,required this.title,required this.onPressed});
final Color color;
final String title;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 10,
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed:  onPressed,
          minWidth: 50,
          height: 42,
          child: Text(title,style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24),
          ),
        ),
      ),
    );
  }
}

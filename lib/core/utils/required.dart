import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequiredString {
  Widget isRequiredControl(String text, bool? isRequired){
    if (isRequired == true){
      return RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(fontSize: 15, color: Colors.black),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }
    return Text(text) ;
  }
}
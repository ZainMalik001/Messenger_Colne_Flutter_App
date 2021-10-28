import 'package:flutter/material.dart';

setTextField(TextEditingController controller, IconData icon, String hintText){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    margin: EdgeInsets.symmetric(horizontal: 4,vertical: 6),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue)
    ),
    child: Row(
      children: [
        Icon(icon,color: Colors.blue),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
            ),
            controller: controller,
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

class NavigateUtil{
 static void navigateToView(BuildContext context, Widget route){
    Navigator.push(context, MaterialPageRoute(builder: (context) => route,));
  }
}
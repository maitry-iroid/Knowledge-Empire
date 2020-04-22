import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ke_employee/helper/res.dart';

class Loader extends StatefulWidget {

  @override
  LoaderState createState() => new LoaderState();
}

class LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: CircularProgressIndicator(backgroundColor:  ColorRes.white,),
      ),
    );
  }
}

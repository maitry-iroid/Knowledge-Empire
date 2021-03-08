import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ke_employee/helper/res.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoreInformation extends StatefulWidget {
  final String url;
  final String title;
  MoreInformation({this.url, this.title});

  @override
  _MoreInformationState createState() => _MoreInformationState();
}

class _MoreInformationState extends State<MoreInformation> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorRes.headerBlue,
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: widget.url,
      )
    );
  }
}

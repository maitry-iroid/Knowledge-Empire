//import 'dart:io';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
//
//import 'dart:async';
//import 'package:path_provider/path_provider.dart';
//
//
//class PdfPage extends StatefulWidget {
//  @override
//  _PdfPageState createState() => _PdfPageState();
//}
//
//class _PdfPageState extends State<PdfPage> {
//
//  String pathPDF = "";
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    createFileOfPdfUrl().then((f) {
//      setState(() {
//        pathPDF = f.path;
//        print(pathPDF);
//      });
//    });
//  }
//
//  Future<File> createFileOfPdfUrl() async {
//    final url = "http://africau.edu/images/default/sample.pdf";
//    final filename = url.substring(url.lastIndexOf("/") + 1);
//    var request = await HttpClient().getUrl(Uri.parse(url));
//    var response = await request.close();
//    var bytes = await consolidateHttpClientResponseBytes(response);
//    String dir = (await getApplicationDocumentsDirectory()).path;
//    File file = new File('$dir/$filename');
//    await file.writeAsBytes(bytes);
//    return file;
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return PDFViewerScaffold(
//        appBar: AppBar(
//          title: Text("Document"),
//          actions: <Widget>[
//            IconButton(
//              icon: Icon(Icons.share),
//              onPressed: () {},
//            ),
//          ],
//        ),
//        path: pathPDF);
//  }
//}

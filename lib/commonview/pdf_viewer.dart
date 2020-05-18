import 'package:flutter/material.dart';
import 'dart:io';

import 'package:ke_employee/helper/Utils.dart';
import 'package:ke_employee/helper/string_res.dart';

class TemplatePageWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String previewPath;

  TemplatePageWidget(
      {@required this.width,
      @required this.height,
      this.isLoading,
      this.previewPath})
      : assert(width > 0.0 && height > 0.0);

  TemplatePageState createState() => new TemplatePageState();
}

class TemplatePageState extends State<TemplatePageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: widget.previewPath != null
            ? new PdfPagePreview(imgPath: widget.previewPath)
            : new CircularProgressIndicator(
                strokeWidth: 2.0,
                value: null,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
      ),
      height: widget.height,
      width: widget.width,
      decoration: new BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              spreadRadius: 1.0, color: Color(0xffebebeb), blurRadius: 3.0),
        ],
        border: Border.all(
          width: 1.0,
          color: Color(0xffebebeb),
        ),
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class PdfPagePreview extends StatefulWidget {
  final String imgPath;

  PdfPagePreview({@required this.imgPath});

  _PdfPagePreviewState createState() => new _PdfPagePreviewState();
}

class _PdfPagePreviewState extends State<PdfPagePreview> {
  bool imgReady = false;
  ImageProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadPreview(needsRepaint: true);
  }

  @override
  void didUpdateWidget(PdfPagePreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imgPath != widget.imgPath) {
      _loadPreview(needsRepaint: true);
    }
  }

  void _loadPreview({@required bool needsRepaint}) {
    if (needsRepaint) {
      imgReady = false;
      provider = FileImage(File(widget.imgPath));
      final resolver = provider.resolve(createLocalImageConfiguration(context));
      resolver.addListener(ImageStreamListener((imgInfo, alreadyPainted) {
        imgReady = true;
        if (!alreadyPainted) setState(() {});
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: imgReady
          ? new Image(
              image: provider,
            )
          : new CircularProgressIndicator(
              strokeWidth: 2.0,
              value: null,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
    );
  }
}
